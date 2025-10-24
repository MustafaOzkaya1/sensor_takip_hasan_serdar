// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'l10n.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class STr extends S {
  STr([String locale = 'tr']) : super(locale);

  @override
  String get appTitle => 'Sensör Takip Uygulaması';

  @override
  String get controlPanel => 'Kontrol Paneli';

  @override
  String get bluetoothOff => 'Bluetooth kapalı. Lütfen açınız.';

  @override
  String get temperatureData => 'Sıcaklık\nVerisi';

  @override
  String get pressureData => 'Basınç\nVerisi';

  @override
  String get humidity => 'Nem Oranı';

  @override
  String get demoMode => 'Demo Modu';

  @override
  String get esp32Connected => 'ESP32 Bağlı';

  @override
  String get settings => 'Ayarlar';

  @override
  String get language => 'Dil Seçimi';

  @override
  String get language_tr => 'Türkçe';

  @override
  String get language_en => 'English';

  @override
  String get language_de => 'Deutsch';

  @override
  String get language_zh => '中文';

  @override
  String get esp32Controls => 'ESP32 Kontrolleri';

  @override
  String get scanAndConnect => 'Tara ve Bağlan';

  @override
  String get disconnect => 'Bağlantıyı Kes';

  @override
  String get restartESP32 => 'ESP32 Yeniden Başlat';

  @override
  String get clearErrors => 'Hataları Temizle';

  @override
  String get connected => 'Bağlı';

  @override
  String get notConnected => 'Bağlı değil';

  @override
  String get toggle => 'Aç/Kapa';
}
