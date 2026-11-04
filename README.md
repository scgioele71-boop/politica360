# Politica 360 — progetto Flutter per Android e Windows

Questa cartella contiene il codice Flutter e la configurazione delle dipendenze. Le cartelle native Android/Windows vengono generate con Flutter sul computer di compilazione.

## Requisiti
- Flutter SDK stabile e Dart compatibile con il vincolo in `pubspec.yaml`.
- Android: Android Studio + Android SDK; accettare le licenze con `flutter doctor --android-licenses`.
- Windows: Windows 10/11 e Visual Studio con workload **Desktop development with C++**.

## Primo avvio
Apri un terminale in questa cartella ed esegui:

```bash
flutter doctor
flutter create . --platforms=android,windows
flutter pub get
```

Per avviare su Windows: `flutter run -d windows`.
Per avviare su Android: collega un dispositivo con debug USB attivo, verifica `flutter devices` e lancia `flutter run -d <device-id>`.

## Creare i pacchetti
- Windows: esegui `GENERA_WINDOWS.bat` oppure `flutter build windows --release`.
- APK Android: esegui `GENERA_APK_ANDROID.bat` oppure `flutter build apk --release`.

Output tipici:
- APK: `build/app/outputs/flutter-apk/app-release.apk`
- Windows: `build/windows/x64/runner/Release/`

Per distribuire un'app Windows con installer firmato/MSIX e un'app Android su Play Store servono ulteriori passaggi di packaging, firma e configurazione degli account.

## Stato funzionale
L'interfaccia attuale è un prototipo navigabile e responsive. Le schermate e le preferenze visive sono presenti, ma le funzionalità seguenti non sono ancora operative: acquisizione automatica delle notizie, API parlamentari/UE, risultati elettorali live, archivio aggiornato dei sondaggi, servizio AI, notifiche push e sincronizzazione/persistenza completa.

Per renderle reali occorre implementare e ospitare un backend, collegare fonti ufficiali e feed/API autorizzati, definire database e autenticazione, e configurare un servizio AI lato server. Le chiavi API non vanno inserite nell'app. I contenuti devono mostrare fonte, data e link originale; i sondaggi vanno aggiornati quando pubblicati, senza inventare rilevazioni giornaliere.

## Moduli previsti
Home, Italia, Europa, Stampa, Elezioni, Sondaggi, Leggi, Atlante politico mondiale, Analisi AI e Preferenze.

## Compilazione automatica con GitHub (senza installare Flutter in locale)
1. Crea un repository GitHub e carica il contenuto di questa cartella.
2. Apri la scheda **Actions** del repository.
3. Seleziona **Build Politica 360** e premi **Run workflow** (oppure fai un push su `main`/`master`).
4. Al termine, apri l'esecuzione completata e scarica gli artifact:
   - `Politica360-Android-APK`: contiene `app-release.apk`.
   - `Politica360-Windows-x64`: contiene lo ZIP della cartella Windows Release.
5. Su Windows, estrai lo ZIP e avvia `politica_360.exe`. Mantieni tutti i file estratti nella stessa cartella: le DLL e le risorse sono necessarie.

La workflow compila i binari, ma non firma l'APK per la pubblicazione su Google Play e non crea un installer Windows (MSIX/Setup). La prima compilazione potrebbe richiedere alcuni minuti.
