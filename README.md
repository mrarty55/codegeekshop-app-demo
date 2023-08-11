# codegeekshop

A simple e-commerce app demonstrated how deep linking is implemented in Flutter.

## Setup project

This project uses Firebase as a backend. Follow [this instruction](https://firebase.google.com/docs/flutter/setup) to add Firebase to your project.

Here's my configuration:

- Create file `dart.config.json` and add environment variables to be used in the project. See [the example](example.config.json)

- Make sure `firebase_app_id_file.json` file exists and is inside `ios` directory.

- Make sure `GoogleService-Info.plist` file exists and is inside `ios/Runner` directory.

- Make sure `google-services.json` file exists and inside `android/app/src` directory.

- To run an app, run `flutter run --dart-define-from-file dart.config.json` from your terminal. If you're using Visual Studio Code, you can simply press `<F5>` to start debugging an app as I have configured the launch settings.

## Test Links

You can simply paste a link in a note app and tap it to see if it will open in an app.

Alternatively, For Android, you can run following command from your terminal to test a link:

```bash
adb shell 'am start -W -a android.intent.action.VIEW \
 -c android.intent.category.BROWSABLE \
 -d "https://codegeek.artyboy.dev/products/codegeek-t-shirt"' \
 dev.artyboy.codegeekshop
```

For iOS Simulator, run following command from your terminal to test a link:

```bash
xcrun simctl openurl booted "https://codegeek.artyboy.dev/products/codegeek-t-shirt"
```
