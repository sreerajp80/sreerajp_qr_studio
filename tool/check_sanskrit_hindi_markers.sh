#!/usr/bin/env bash
# Sanskrit Hindi-marker gate, copied from
# docs/guidelines/language_packs/sanskrit_malayalam.md §4.1. Run from the project root.

set -uo pipefail

# CI check: fail if any Hindi marker appears in the Sanskrit ARB,
# app_config.json, or Sanskrit asset files.
# Uses PCRE (-P) with lookarounds so standalone copulas/words are not confused with
# legitimate Sanskrit roots (e.g. स्थाप्यताम्, स्थानम्) or indeclinables (यथा, तथा, कथा).
# Word edges: whitespace, quotes, brackets, punctuation, daṇḍa, XML/HTML tag edges (< >),
# and Markdown marks (* _ ` # | : ; ~ -) so help files in Markdown are checked too.
PATTERN='(?<=[\s"'\''([{<>।,*_`#|:;~-]|^)(?:था|थे|थी|हो|है|हैं|हूं|और)(?=[\s"'\''\)\]}<>।,.\?!*_`#|:;~-]|$)|करें|करना|करके|रहा|रही|रहे|गया|गयी|चाहिए|नहीं|लेकिन|क्या|आपका|आपकी|आपके|हमारा|मेरा|कृपया|सेटिंग्स|ऐप|\x{093C}|[\x{0958}-\x{095F}]'

mapfile -t FILES < <(find . -path '*/build' -prune -o -type f \( \
    -name 'app_sa.arb' -o \
    -path '*/assets/*_sa.*' -o \
    -path '*/assets/config/app_config.json' \) -print)

if [ "${#FILES[@]}" -eq 0 ]; then
  echo 'No Sanskrit files found — the project declares sa but app_sa.arb is missing.'; exit 1
fi

# Self-test: the pattern must still catch a Hindi copula in ARB/JSON, XML and Markdown text.
for sample in '"greeting": "है"' '<b>है</b>' 'यह **है**' 'यह `है`' 'वह *था*'; do
  if ! printf '%s\n' "$sample" | LC_ALL=C.UTF-8 grep -qP "$PATTERN"; then
    echo "Sanskrit check self-test failed on: $sample"; exit 1
  fi
done

if LC_ALL=C.UTF-8 grep -nP "$PATTERN" "${FILES[@]}"; then
  echo 'Hindi markers found in Sanskrit text (language pack §4.1).'; exit 1
fi
exit 0
