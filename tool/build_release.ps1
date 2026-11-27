<#
.SYNOPSIS
  Build an Android release (APK or AAB), give the files proper names and write a SHA-256
  checksum file for each one.

.DESCRIPTION
  Runs `flutter build apk|appbundle` with the release hardening flags (obfuscation and split
  debug info, split APKs), then renames each output to
    <Name>-[<abi>-]v<x.y.z>_<build>-<flavor>-<mode>.<apk|aab>
  removes Flutter's SHA-1 file and writes <file>.sha256 in `sha256sum` format.
  Flutter writes the .sha1 after Gradle finishes, so this cannot be done in a Gradle task.

  Writes only inside build/. Never reads android/key.properties or the keystore: Gradle signs.
  Works in Windows PowerShell 5.1 and PowerShell 7. Full guide: docs/release_process.md 6.10.

.EXAMPLE
  .\tool\build_release.ps1 -Name QRForge -Target aab
.EXAMPLE
  .\tool\build_release.ps1 -Name QRForge -Target apk
.EXAMPLE
  .\tool\build_release.ps1 -Name QRForge -Target apk -Flavor dev -Mode debug
#>
[CmdletBinding()]
param(
    [ValidatePattern('^[A-Za-z0-9._-]+$')]
    [string]$Name,

    [ValidateSet('apk', 'aab')]
    [string]$Target,

    [ValidateSet('dev', 'prod')]
    [string]$Flavor = 'prod',

    [ValidateSet('release', 'profile', 'debug')]
    [string]$Mode = 'release',

    [switch]$NoSplit,

    [switch]$NoObfuscate,

    [string]$SymbolsDir
)

$ErrorActionPreference = 'Stop'

# The production flavor. Its release builds must be obfuscated and split per ABI.
$ProdFlavor = 'prod'

function Stop-WithError([string]$Message) {
    Write-Host "ERROR: $Message" -ForegroundColor Red
    exit 1
}

# ---- 1. Required options and version -------------------------------------------------------

if ([string]::IsNullOrWhiteSpace($Name)) {
    Stop-WithError '-Name is required (base file name, letters, digits, dot, dash, underscore). Example: -Name QRForge'
}
if ([string]::IsNullOrWhiteSpace($Target)) {
    Stop-WithError '-Target is required: apk or aab.'
}

$RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$Pubspec = Join-Path $RepoRoot 'pubspec.yaml'
if (-not (Test-Path -LiteralPath $Pubspec)) {
    Stop-WithError "pubspec.yaml not found in $RepoRoot."
}

$versionLine = Get-Content -LiteralPath $Pubspec | Where-Object { $_ -match '^version:' } | Select-Object -First 1
if (-not $versionLine) {
    Stop-WithError 'No "version:" line in pubspec.yaml.'
}
if ($versionLine -notmatch '^version:\s*([0-9]+\.[0-9]+\.[0-9]+)\+([0-9]+)\s*$') {
    Stop-WithError "pubspec.yaml version must look like x.y.z+n (the +n build number is required). Found: $versionLine"
}
$VersionName = $Matches[1]
$BuildNumber = $Matches[2]
$FullVersion = "$VersionName+$BuildNumber"

# ---- 2. Check the options before running Flutter -------------------------------------------

$isProdRelease = ($Flavor -eq $ProdFlavor) -and ($Mode -eq 'release')

if ($NoObfuscate -and $isProdRelease) {
    Stop-WithError "-NoObfuscate is not allowed for a $ProdFlavor release build: it must be obfuscated."
}

$obfuscate = -not $NoObfuscate
if ($Mode -eq 'debug' -and $obfuscate) {
    Write-Host 'Debug mode: --obfuscate and --split-debug-info are left out (Flutter supports them only in profile and release).'
    $obfuscate = $false
}

if ($SymbolsDir -and -not $obfuscate) {
    Stop-WithError '-SymbolsDir is only used for an obfuscated build (it is passed to --split-debug-info).'
}

$split = $false
if ($Target -eq 'aab') {
    if ($NoSplit) { Write-Host '-NoSplit is ignored for aab (a bundle is never split by Flutter).' }
} else {
    if ($NoSplit -and $isProdRelease) {
        Stop-WithError "-NoSplit is not allowed for a $ProdFlavor release APK: direct downloads use split APKs only (engineering standard 5.6)."
    }
    $split = -not $NoSplit
}

$BuildRoot = [IO.Path]::GetFullPath((Join-Path $RepoRoot 'build'))
$symbolsFull = $null
if ($obfuscate) {
    if (-not $SymbolsDir) {
        $suffix = if ($Target -eq 'apk') { '-apk' } else { '' }
        $SymbolsDir = "build/symbols/android-$Flavor-$FullVersion$suffix/"
    }
    $symbolsFull = [IO.Path]::GetFullPath([IO.Path]::Combine($RepoRoot, $SymbolsDir))
    $buildPrefix = $BuildRoot.TrimEnd('\', '/') + [IO.Path]::DirectorySeparatorChar
    if (-not $symbolsFull.StartsWith($buildPrefix, [StringComparison]::OrdinalIgnoreCase)) {
        Stop-WithError "-SymbolsDir must be inside build/ (got $symbolsFull)."
    }
}

# ---- Paths Flutter uses (Flutter 3.50: CopyFlutterApksTask.kt, gradle.dart) ----------------

$ApkDir = Join-Path $RepoRoot 'build\app\outputs\flutter-apk'
$ModeCap = $Mode.Substring(0, 1).ToUpperInvariant() + $Mode.Substring(1)
$BundleDir = Join-Path $RepoRoot "build\app\outputs\bundle\$Flavor$ModeCap"
$BundleFile = Join-Path $BundleDir "app-$Flavor-$Mode.aab"

$ShortAbi = @{
    'armeabi-v7a' = 'armeabi'
    'arm64-v8a'   = 'arm64'
    'x86_64'      = 'x86_64'
    'x86'         = 'x86'
}

# Exact Flutter APK names for this flavor and mode: app[-<abi>]-<flavor>-<mode>.apk[.sha1].
# A strict pattern, so a renamed file is never taken for a Flutter output (even with -Name app).
$abiAlternatives = ($ShortAbi.Keys | ForEach-Object { [regex]::Escape($_) }) -join '|'
$FlutterApkPattern = '^app(?:-(' + $abiAlternatives + '))?-' + [regex]::Escape("$Flavor-$Mode") + '\.apk(\.sha1)?$'

# SHA-256 through .NET, not Get-FileHash: Windows PowerShell 5.1 started from PowerShell 7
# can fail to load the module that holds Get-FileHash (mixed PSModulePath).
function Get-Sha256Hex([string]$Path) {
    $sha = [System.Security.Cryptography.SHA256]::Create()
    $stream = [System.IO.File]::OpenRead($Path)
    try {
        $bytes = $sha.ComputeHash($stream)
    } finally {
        $stream.Dispose()
        $sha.Dispose()
    }
    return ([System.BitConverter]::ToString($bytes) -replace '-', '').ToLowerInvariant()
}

function Format-Size([long]$Bytes) {
    return ('{0:N1} MB' -f ($Bytes / 1MB))
}

$exitCode = 0
Push-Location -LiteralPath $RepoRoot
try {
    # ---- 3. Delete old Flutter-named output, so a stale file is never renamed as this build ----
    if ($Target -eq 'apk') {
        if (Test-Path -LiteralPath $ApkDir) {
            Get-ChildItem -LiteralPath $ApkDir -File |
                Where-Object { $_.Name -match $FlutterApkPattern } |
                ForEach-Object {
                    Write-Host "Removing old output: $($_.Name)"
                    Remove-Item -LiteralPath $_.FullName -Force
                }
        }
    } elseif (Test-Path -LiteralPath $BundleFile) {
        Write-Host "Removing old output: $(Split-Path -Leaf $BundleFile)"
        Remove-Item -LiteralPath $BundleFile -Force
    }

    # ---- 4. Build ------------------------------------------------------------------------
    $buildDate = Get-Date -Format 'yyyy-MM-dd'
    $flutterArgs = @('build')
    $flutterArgs += if ($Target -eq 'apk') { 'apk' } else { 'appbundle' }
    $flutterArgs += @('--flavor', $Flavor, "--$Mode")
    if ($split) { $flutterArgs += '--split-per-abi' }
    if ($obfuscate) { $flutterArgs += @('--obfuscate', "--split-debug-info=$SymbolsDir") }
    $flutterArgs += "--dart-define=BUILD_DATE=$buildDate"

    Write-Host "Building $Flavor $Mode $Target $FullVersion"
    Write-Host "> flutter $($flutterArgs -join ' ')"
    & flutter @flutterArgs
    if ($LASTEXITCODE -ne 0) {
        throw "flutter build failed (exit code $LASTEXITCODE). Nothing was renamed or hashed."
    }

    # ---- Collect the new outputs ----------------------------------------------------------
    $outputs = @()  # items: @{ Path = ...; Abi = ... }
    if ($Target -eq 'apk') {
        if (Test-Path -LiteralPath $ApkDir) {
            foreach ($f in Get-ChildItem -LiteralPath $ApkDir -File) {
                if ($f.Name -notmatch $FlutterApkPattern -or $Matches[2]) { continue }  # skip .sha1
                $abi = $Matches[1]
                # Split build: per-ABI files only. Universal build: the file without an ABI.
                if (($split -and $abi) -or (-not $split -and -not $abi)) {
                    $outputs += @{ Path = $f.FullName; Abi = $abi }
                }
            }
        }
    } elseif (Test-Path -LiteralPath $BundleFile) {
        $outputs += @{ Path = $BundleFile; Abi = '' }
    }
    if ($outputs.Count -eq 0) {
        throw "flutter build succeeded but no $Target output was found where Flutter writes it."
    }

    # ---- 5-7. Rename, drop .sha1, write .sha256 -------------------------------------------
    $ext = if ($Target -eq 'apk') { 'apk' } else { 'aab' }
    $utf8NoBom = New-Object System.Text.UTF8Encoding($false)
    $results = @()
    foreach ($out in $outputs) {
        $abiPart = ''
        if ($out.Abi) {
            $short = $ShortAbi[$out.Abi]
            if (-not $short) { $short = $out.Abi }
            $abiPart = "$short-"
        }
        $newName = "$Name-${abiPart}v${VersionName}_$BuildNumber-$Flavor-$Mode.$ext"
        $dir = Split-Path -Parent $out.Path
        $newPath = Join-Path $dir $newName

        if (Test-Path -LiteralPath $newPath) {
            Write-Host "Replacing existing file: $newName"
            Remove-Item -LiteralPath $newPath -Force
        }
        Move-Item -LiteralPath $out.Path -Destination $newPath

        $sha1 = "$($out.Path).sha1"
        if (Test-Path -LiteralPath $sha1) { Remove-Item -LiteralPath $sha1 -Force }

        $hash = Get-Sha256Hex $newPath
        [IO.File]::WriteAllText("$newPath.sha256", "$hash  $newName`n", $utf8NoBom)

        $results += [pscustomobject]@{
            Path   = $newPath
            Size   = (Get-Item -LiteralPath $newPath).Length
            Sha256 = $hash
        }
    }

    # ---- 8. Report ------------------------------------------------------------------------
    Write-Host ''
    Write-Host 'Built files:'
    foreach ($r in $results) {
        $rel = $r.Path.Substring($RepoRoot.Length).TrimStart('\', '/')
        Write-Host "  $rel  ($(Format-Size $r.Size))"
        Write-Host "    SHA-256: $($r.Sha256)"
        Write-Host "    Checksum file: $rel.sha256"
    }
    if ($obfuscate) {
        Write-Host ''
        Write-Host "Debug symbols: $SymbolsDir"
        Write-Host '  Archive this folder outside the repository with this release.'
    }
} catch {
    Write-Host "ERROR: $($_.Exception.Message)" -ForegroundColor Red
    $exitCode = 1
} finally {
    Pop-Location
    # ---- 9. Stop the Gradle daemons, so they do not hold memory ---------------------------
    $gradlew = Join-Path $RepoRoot 'android\gradlew.bat'
    if (Test-Path -LiteralPath $gradlew) {
        Write-Host ''
        Write-Host 'Stopping Gradle daemons...'
        & $gradlew --stop | Out-Host
    }
}
exit $exitCode
