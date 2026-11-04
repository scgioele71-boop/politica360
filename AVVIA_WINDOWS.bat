@echo off
setlocal
where flutter >nul 2>nul
if errorlevel 1 (
  echo Flutter non trovato. Installa Flutter SDK e aggiungilo al PATH.
  pause
  exit /b 1
)
if not exist windows\CMakeLists.txt flutter create . --platforms=windows,android
flutter pub get
flutter run -d windows
pause
