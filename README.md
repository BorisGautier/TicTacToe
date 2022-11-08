# TicTacToe With Annette

Welcome to My Project

## How to run flutter in Vs code

- Visual Studio Code is a lightweight but powerful source code editor(optinal)(for vscode, all above setup for Android Studio are required).
- For Download VSCode Click Here
- Open vs code and go to terminal option and open terminal
- Inside Terminal For Run the Application perform this two command
  1. flutter pub get (flutter packages get)
  2. flutter run

## How to change package name

- run flutter pub run change_app_package_name:main com.new.package.name

## How to integrate firebase

- Create firebase project in your account
- Add andorid application to your firebase project
- Visit https://developers.google.com/android/guides/client-auth to know how to get sha-1 key
- You have connected andorid application to your firebase project successfully
- Download the google-services.json file and add it in the [your-flutter-project-dir]/android/app folder
- Add ios application to your firebase project
- Get your bundle id here [your-flutter-project-dir]\ios\Runner.xcodeproj\project.pbxproj or search for PRODUCT_BUNDLE_IDENTIFIER and you will get following result
- You have connected ios application to your firebase project successfully
- Download the GoogleService-Info.plist file and add it in the [your-flutter-project-dir]/ios/Runner folder

### How to enable firebase auth

- Activer les methodes d'authentification suivantes:
  - Email/Password
  - Google
  - Apple
  - Anonymous

<a name="contribute"></a>

## Contribute

You can contribute us by filing issues, bugs and PRs.

### Contributing:

- Open issue regarding proposed change.
- Repo owner will contact you there.
- If your proposed change is approved, Fork this repo and do changes.
- Open PR against latest `dev` branch. Add nice description in PR.
- You're done!
