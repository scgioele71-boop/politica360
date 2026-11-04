@echo off
setlocal
where flutter >nul 2>nul
if errorlevel 1 (
  echo Flutter non trovato. Installa Flutter SDK e aggiungilo al PATH.
  pause
  exit /b 1
)
if not exist android\app\build.gradle flutter create . --platforms=android,windows
flutter pub get
flutter build apk --release
if exist build\app\outputs\flutter-apk\app-release.apk (
  echo APK creato: build\app\outputs\flutter-apk\app-release.apk
) else (
  echo Build non riuscita. Controlla Android SDK e licenze con: flutter doctor
)
pause
