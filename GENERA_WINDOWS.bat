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
flutter build windows --release
if exist build\windows\x64\runner\Release\politica_360.exe (
  echo App Windows creata in build\windows\x64\runner\Release\
) else (
  echo Build non riuscita. Verifica Visual Studio con Desktop development with C++.
)
pause
