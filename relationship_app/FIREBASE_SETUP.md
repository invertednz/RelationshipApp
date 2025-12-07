# Firebase Setup for Relationship App

This folder already contains the base wiring for Firebase. You only need to:

1. Run one setup script (which runs the FlutterFire CLI for you).
2. Hook a single initializer call into `main.dart` when you are ready to use Firebase.

---

## What’s already in place

- `firebase_core` dependency added in `pubspec.yaml`.
- Stub `lib/firebase_options.dart` compatible with the FlutterFire CLI output (will be overwritten).
- Helper `lib/firebase_initializer.dart` with `initializeFirebase()`.
- Script `scripts/setup_firebase.ps1` to run the FlutterFire configuration.

---

## One-time setup

### 1. Prerequisites

- Flutter SDK installed and on your `PATH`.
- A Firebase project created in the Firebase console.
- PowerShell (built-in on Windows).

From a terminal in the `relationship_app` directory:

```bash
flutter pub get
```

### 2. Run the Firebase setup script

From the same directory on Windows PowerShell:

```powershell
./scripts/setup_firebase.ps1 -ProjectId YOUR_FIREBASE_PROJECT_ID
```

If you omit `-ProjectId`, the script will run:

```powershell
flutterfire configure --platforms=android,ios
```

and you can select the project interactively.

The script will:

- Activate the FlutterFire CLI (`dart pub global activate flutterfire_cli`).
- Run `flutterfire configure` so that:
  - `lib/firebase_options.dart` is generated with real config values (overwriting the stub).
  - Native Android/iOS projects are wired to Firebase.

> Note: After `dart pub global activate flutterfire_cli`, you may need to restart your terminal or ensure your Dart pub global bin folder is on `PATH` so that the `flutterfire` command is available.

---

## Initialize Firebase in `main.dart`

When you are ready to actually use Firebase in the app, add the following to `lib/main.dart`:

1. Import the initializer:

```dart
import 'firebase_initializer.dart';
```

2. Call the initializer near the top of `main()` after `WidgetsFlutterBinding.ensureInitialized();`:

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeFirebase();

  // existing Hive initialization and app startup...
}
```

This will:

- Use `DefaultFirebaseOptions.currentPlatform` from the generated `firebase_options.dart`.
- Initialize Firebase before the rest of your app runs.

---

## Adding more Firebase products later

To add more Firebase features (Auth, Firestore, etc.):

1. Add the desired plugin, for example:

```bash
flutter pub add firebase_auth
flutter pub add cloud_firestore
```

2. Re-run configuration so native projects stay in sync:

```bash
flutterfire configure
```

3. Use the new Firebase APIs in your Dart code as needed.

---

## Troubleshooting

- If `flutterfire` is not recognized, ensure your Dart pub global bin directory is on `PATH`, or reopen the terminal after running the setup script.
- If the app throws `UnimplementedError` from `DefaultFirebaseOptions.currentPlatform`, it means you are calling `initializeFirebase()` before running the setup script and generating a real `firebase_options.dart` file.
- Re-run `flutterfire configure` any time you add/remove platforms or Firebase products that require native changes.
