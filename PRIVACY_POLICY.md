# Privacy Policy — SreerajP QR Studio

**Effective date:** 10 October 2026

This policy explains what the Android app **SreerajP QR Studio** (package
`in.sreerajp.qr_studio`) does with your data. The app is made by Sreeraj P,
an individual developer.

---

## 1. Summary

- You do not need an account. The app does not ask for your name, email, or
  phone number.
- The app has **no analytics, no ads, no tracking, and no crash reporting**.
- The developer has **no server**. The developer never receives your scans,
  your history, or anything else from the app.
- Scanning and decoding happen **on your phone**. The app uses its own
  built-in barcode decoder, not a cloud service.
- A few optional features send a scanned link to an online service. They are
  **off by default**, and you choose to turn them on (see section 4).

---

## 2. Permissions and why the app uses them

| Permission | Why it is used |
| --- | --- |
| Camera | To scan QR codes and barcodes. Asked only when you start scanning. Camera images are decoded on the phone and are not saved or sent anywhere. |
| Screen capture (GhostScan) | To read a code that is shown on your own screen. Android asks you each time. The app takes one picture of the screen, decodes it on the phone, and then throws it away. |
| Display over other apps | For the optional Scan bubble, a floating button you can turn on in Settings. |
| Foreground service | To keep the Scan bubble and screen capture running while you use them. Android shows a notification while it runs. |
| Notifications | To show that notification. |
| Start at boot | To bring back the Scan bubble after a restart, but only if you left it turned on. |
| Location | Only when you ask CodeForge to make a QR code with your current location. The location is read once and put into the code you make. It is not stored or sent by the app. |
| Wi-Fi and network state | To join a Wi-Fi network from a Wi-Fi QR code when you tap "Connect", and to check whether you are online. |
| Biometrics (fingerprint / face) | To unlock protected StegoQR content, if you choose. Android handles the check; the app never sees your fingerprint or face data. |
| Internet | Only for the optional online features in section 4. |

---

## 3. Data stored on your phone

- **Scan history.** Stored in an encrypted database on your phone. The
  encryption key is kept in Android's secure storage.
- **Settings.** Your choices, such as language and theme.
- **API keys you add.** If you add your own Google Safe Browsing or
  VirusTotal key, it is kept in Android's secure storage.
- **Clipboard.** When you open the scanner, the app looks at the clipboard to
  offer a quick scan of a link or code you copied. This happens on the phone
  and is not saved or sent anywhere.

Android backup is turned off for this app, so this data is not copied to
cloud backup.

**Deleting your data.** You can delete single items or all history inside the
app. Clearing the app's data in Android settings, or uninstalling the app,
removes everything.

**Export and AirQR.** If you export your history, share a scan, or move data
to another phone with AirQR, that happens only when you choose to, and the
data goes only where you send it.

---

## 4. Data that leaves your phone (only when you choose)

| Feature | What is sent | Sent to | When |
| --- | --- | --- | --- |
| Link safety providers | The scanned link | [Google Safe Browsing](https://policies.google.com/privacy), [VirusTotal](https://www.virustotal.com/gui/privacy-policy), [URLhaus](https://abuse.ch/privacy-policy/), [PhishTank](https://phishtank.org/), [OpenPhish](https://openphish.com/) | Only for the providers you turn on in Settings. All are off by default. |
| Active online checks | A request to the scanned website, to follow redirects or open short links | The website in the scanned code | Only if you turn this on. Off by default. |
| Page preview | A request for the scanned page, and its domain name to look up the domain's age | The website, and [rdap.org](https://rdap.org/) | Only if you turn on "Active online checks" (off by default). It then runs by itself after you scan a link. |
| Smart actions | The scanned content needed for the action (for example a product barcode or an address) | Opens in your browser or another app (for example Maps, Calendar, Open Food Facts, Google Books) | Only when you tap the action. |

When the app talks to a website or service, that service can see your
device's IP address, like any website you visit. Each service has its own
privacy policy. Requests to the safety services and rdap.org use HTTPS
(encrypted). A scanned website is contacted using the address in the code.

The developer does not receive any of this data.

---

## 5. Children

The app is not aimed at children. It does not knowingly collect any data from
anyone, including children.

---

## 6. Security

- Scan history is encrypted on the phone.
- API keys are kept in Android's secure storage, never in plain settings.
- The app does not write secrets or your scan content to logs.
- Requests to safety services use HTTPS.

---

## 7. Changes to this policy

If this policy changes, the new version will be posted at the same link with
a new effective date.

---

## 8. Contact

Questions about this policy: **sreerajp@zohomail.in**
