# Jack
A utility tool to help control my Mac

## Prerequisites
- Flutter installed on your machine
- An Android or iOS device
- An active internet connection

## Getting Started
It's easy to get started. Just plug in your device and, follow:
- Create a file at ```lib/utils/details.dart``` mentioning the following details:
```
var username = macOSUsername;
var host = macOSIpOnSameWifiYourMobileAndMacAreConnectedTo;
var port = 22 (usually, until a custom SSH port hasn't been specified which is unlikely);
var password = yourMacOSPasswordForTheAboveUsername;
```
- If you use IDE's for flutter development
  - Connect your device
  - Build the application by the IDE you use for flutter development.
  - Or run ``` flutter run --release ``` on your console to build the app.
  - Authenticate the app with yout fingerprint and continue.
- If you use terminal or CMD for flutter development
  - Connect your device.
  - Run ``` flutter run --release ``` on your console.
  - Authenticate the app with yout fingerprint and continue.
  - Click the camera button to open the Scanner and point and scan.
- If you want to just build the apk
  - Run ``` flutter build apk --release ``` (for Android users)

PS, if you face any issues anywhere please feel free to open up a thread. I would love to help you out as soon as possible.

# Known Issue
None as of now. Currently, I'm trying to add a section to show a log of scanned QR Codes. Feel free to open an issue if any!

## Wanna Contribute ?
Aww, great. Just go through [CONTRIBUTING.MD](https://github.com/dewanshrawat15/jack/blob/master/CONTRIBUTING.md) once!

# References
- Icon referenced from [Ronish Sawal's Behance](https://www.behance.net/gallery/78853939/FAKE-Concept-Art)

# License
> The MIT License
