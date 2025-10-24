// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'l10n.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class SDe extends S {
  SDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'Sensor-Tracking-App';

  @override
  String get controlPanel => 'Kontrollpanel';

  @override
  String get bluetoothOff => 'Bluetooth ist aus. Bitte aktivieren.';

  @override
  String get temperatureData => 'Temperatur\nDaten';

  @override
  String get pressureData => 'Druck\nDaten';

  @override
  String get humidity => 'Luftfeuchtigkeit';

  @override
  String get demoMode => 'Demo-Modus';

  @override
  String get esp32Connected => 'ESP32 verbunden';

  @override
  String get settings => 'Einstellungen';

  @override
  String get language => 'Sprache';

  @override
  String get language_tr => 'Türkisch';

  @override
  String get language_en => 'Englisch';

  @override
  String get language_de => 'Deutsch';

  @override
  String get language_zh => 'Chinesisch';

  @override
  String get esp32Controls => 'ESP32-Steuerungen';

  @override
  String get scanAndConnect => 'Scannen und Verbinden';

  @override
  String get disconnect => 'Verbindung trennen';

  @override
  String get restartESP32 => 'ESP32 neu starten';

  @override
  String get clearErrors => 'Fehler löschen';

  @override
  String get connected => 'Verbunden';

  @override
  String get notConnected => 'Nicht verbunden';

  @override
  String get toggle => 'Ein/Aus';
}
