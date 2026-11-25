# StudyShare

Flutter mobile front end for the StudyShare login and sign-up flows. The screens use local SVG branding and campus artwork, responsive layouts, inline validation, secure remembered-email storage, animated routing, and a mock authentication repository.

## Run

1. Install Flutter and Android Studio with an Android SDK.
2. From this directory run `flutter pub get`.
3. Connect an Android device or start an emulator, then run `flutter run`.

Authentication currently uses a short mock delay. Connect the `AuthRepository` methods to Firebase or another authentication service when the backend is ready.

## Checks

- `flutter analyze`
- `flutter test`
