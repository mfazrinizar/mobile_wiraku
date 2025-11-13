# Wiraku — Mobile Computing Midterm

A Flutter demo app showcasing a hero detail view with:
- Draggable "WIRA LAINNYA" sheet
- Per-hero comments modal
- Animated image transitions when switching heroes

Quick links
- Main entry: [`lib/main.dart`](lib/main.dart)
- Screen: [`WiraView`](lib/view/wira_view.dart) — [`lib/view/wira_view.dart`](lib/view/wira_view.dart)
- Hero detail: [`InfoWira`](lib/components/info_wira.dart) — [`lib/components/info_wira.dart`](lib/components/info_wira.dart)
- Hero list item: [`ItemWira`](lib/components/item_wira.dart) — [`lib/components/item_wira.dart`](lib/components/item_wira.dart)
- Comments modal: [`KomentarModal`](lib/components/komentar_modal.dart) — [`lib/components/komentar_modal.dart`](lib/components/komentar_modal.dart)
- Windows native window: [`windows/runner/win32_window.cpp`](windows/runner/win32_window.cpp)

Prerequisites
- Flutter SDK (stable). See https://flutter.dev
- For Windows desktop: Visual Studio with "Desktop development with C++" and CMake
- For macOS/iOS: Xcode
- For Linux: GTK dev packages (depends on distro)

Run (development)
1. Install packages:
   ```sh
   flutter pub get
   ```
2. Run on a device or desktop:
   - Android: flutter run -d emulator-5554
   - iOS (macOS): flutter run -d <device>
   - Windows desktop: flutter run -d windows
   - Web: flutter run -d chrome

Build
- Android (release):
  ```sh
  flutter build apk --release
  ```
- Windows:
  ```sh
  flutter build windows
  ```

Notes
- Comments are stored per-hero in the view state (see [`lib/view/wira_view.dart`](lib/view/wira_view.dart)).
- The image slide animation is implemented in [`lib/components/info_wira.dart`](lib/components/info_wira.dart) using an `AnimatedSwitcher` transition.
- The DraggableScrollableSheet for "WIRA LAINNYA" lives in [`lib/view/wira_view.dart`](lib/view/wira_view.dart).
- If desktop build fails on Windows, check `windows/runner` files and ensure Visual Studio + CMake are installed.
- Please make sure the graddle properties in [`android\gradle.properties`](android\gradle.properties) `org.gradle.java.home` is set to your JAVA home path (or delete it if you have set and don't have multiple JDKs).