// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'l10n.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class SEn extends S {
  SEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Sensor Tracking App';

  @override
  String get controlPanel => 'Control Panel';

  @override
  String get bluetoothOff => 'Bluetooth is off. Please enable it.';

  @override
  String get temperatureData => 'Temperature\nData';

  @override
  String get pressureData => 'Pressure\nData';

  @override
  String get humidity => 'Humidity';

  @override
  String get demoMode => 'Demo Mode';

  @override
  String get esp32Connected => 'ESP32 Connected';

  @override
  String get settings => 'Settings';

  @override
  String get language => 'Language';

  @override
  String get language_tr => 'Turkish';

  @override
  String get language_en => 'English';

  @override
  String get language_de => 'German';

  @override
  String get language_zh => 'Chinese';

  @override
  String get esp32Controls => 'ESP32 Controls';

  @override
  String get scanAndConnect => 'Scan and Connect';

  @override
  String get disconnect => 'Disconnect';

  @override
  String get restartESP32 => 'Restart ESP32';

  @override
  String get clearErrors => 'Clear Errors';

  @override
  String get connected => 'Connected';

  @override
  String get notConnected => 'Not connected';

  @override
  String get toggle => 'Toggle';
}
