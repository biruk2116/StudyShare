# StudyShare

Flutter mobile front end for the StudyShare authentication flows. Login, registration, and forgot-password screens use responsive layouts, shared local SVG artwork, inline validation, secure remembered-email storage, animated routing, and a mock authentication repository. Android has a matching StudyShare launcher icon and splash mark.

## Run

1. Install Flutter and Android Studio with an Android SDK.
2. From this directory run `flutter pub get`.
3. Connect an Android device or start an emulator, then run `flutter run`.

Sign-in and registration currently use a short mock delay. Password-reset email delivery is not implemented; connect a `sendPasswordResetEmail` method in `AuthRepository` to the authentication backend before enabling delivery.

## Checks

- `flutter analyze`
- `flutter test`
