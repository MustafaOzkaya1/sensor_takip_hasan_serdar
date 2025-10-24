# 🌡️ ESP32 Sensör Takip Uygulaması

ESP32 mikrodenetleyicisinden Bluetooth Low Energy (BLE) üzerinden sıcaklık, nem ve basınç verilerini alan modern bir Flutter uygulaması.

## ✨ Özellikler

- 📊 **Gerçek Zamanlı Veri İzleme**: ESP32'den gelen sıcaklık, nem ve basınç verilerini canlı olarak görüntüleyin
- 🎨 **Modern UI**: Figma tasarımına sadık, karanlık tema ile şık arayüz
- 📱 **Çoklu Platform**: iOS, Android, macOS, Windows ve Linux desteği
- 🔄 **Demo Modu**: ESP32 bağlı olmadan test için mock data desteği
- 🎛️ **Sensör Kontrolü**: Her sensörü ayrı ayrı açıp kapatma özelliği
- 🔔 **Bildirimler**: Anlık bildirim desteği (yakında)

## 📱 Ekran Görüntüleri

Uygulama ana ekranı:
- Sıcaklık kartı (°C)
- Basınç kartı (%)
- Nem oranı göstergesi
- Alt navigasyon menüsü

## 🔧 Kurulum

### Gereksinimler

- Flutter SDK (3.7.2 veya üzeri)
- ESP32 geliştirme kartı
- BME280 sensör modülü (opsiyonel - yoksa mock data kullanılır)
- Arduino IDE (ESP32 için)

### Flutter Uygulaması

1. Projeyi klonlayın:
```bash
git clone [repo-url]
cd sensor_takip_uygulamasi
```

2. Bağımlılıkları yükleyin:
```bash
flutter pub get
```

3. Uygulamayı çalıştırın:
```bash
# Android/iOS için
flutter run

# macOS için
flutter run -d macos

# Web için
flutter run -d chrome
```

### ESP32 Kurulumu

1. Arduino IDE'yi açın
2. `esp32_code/sensor_ble_server.ino` dosyasını açın
3. Gerekli kütüphaneleri yükleyin:
   - ESP32 Board Manager
   - Adafruit BME280 Library
   - Adafruit Unified Sensor

4. BME280 sensörünü ESP32'ye bağlayın:
   ```
   BME280 -> ESP32
   VCC    -> 3.3V
   GND    -> GND
   SCL    -> GPIO 22
   SDA    -> GPIO 21
   ```

5. Kodu ESP32'ye yükleyin

## 📡 Veri Formatı

ESP32'den gelen veri formatı:
```
24.00,47.50,1012.50
```
- İlk değer: Sıcaklık (°C)
- İkinci değer: Nem (%)
- Üçüncü değer: Basınç (hPa)

## 🏗️ Proje Yapısı

```
lib/
├── main.dart                 # Ana uygulama dosyası
├── models/
│   └── sensor_data.dart      # Sensör veri modeli
├── providers/
│   └── sensor_provider.dart  # State management
├── screens/
│   └── home_screen.dart      # Ana ekran
├── services/
│   ├── esp32_service.dart    # ESP32 BLE servisi
│   └── mock_sensor_service.dart # Mock veri servisi
└── widgets/
    └── sensor_card.dart      # Sensör kartı widget'ı

esp32_code/
└── sensor_ble_server.ino     # ESP32 Arduino kodu
```

## 🎨 Tasarım

Uygulama Figma'da tasarlanmıştır. Tasarım öğeleri:

- **Renk Paleti**:
  - Arka Plan: `#211D1D`
  - Kart Arka Planı: `#282424`
  - Accent: `#FFB267` (Turuncu)
  - Metin: `#F8F8F8` (Beyaz)

- **Tipografi**: Manrope font ailesi
- **Border Radius**: 24px (kartlar için)

## 🔐 İzinler

### Android
`AndroidManifest.xml` dosyasına aşağıdaki izinleri ekleyin:
```xml
<uses-permission android:name="android.permission.BLUETOOTH" />
<uses-permission android:name="android.permission.BLUETOOTH_ADMIN" />
<uses-permission android:name="android.permission.BLUETOOTH_SCAN" />
<uses-permission android:name="android.permission.BLUETOOTH_CONNECT" />
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
```

### iOS
`Info.plist` dosyasına aşağıdaki anahtarları ekleyin:
```xml
<key>NSBluetoothAlwaysUsageDescription</key>
<string>Bu uygulama ESP32 cihazına bağlanmak için Bluetooth kullanır</string>
<key>NSBluetoothPeripheralUsageDescription</key>
<string>Bu uygulama sensör verilerini almak için Bluetooth kullanır</string>
```

## 🚀 Kullanım

1. **Demo Modu**: Uygulama varsayılan olarak demo modunda başlar ve mock data gösterir
2. **ESP32 Bağlantısı**: 
   - ESP32'yi açın
   - Ayarlar menüsünden "ESP32'ye Bağlan" seçeneğini kullanın
   - Yakındaki ESP32 cihazları taranacak ve otomatik bağlanacaktır
3. **Sensör Kontrolü**: Her kartın altındaki switch ile sensörü açıp kapatabilirsiniz

## 📦 Kullanılan Paketler

- `provider`: State management
- `flutter_blue_plus`: Bluetooth Low Energy iletişimi
- `google_fonts`: Manrope font için
- `permission_handler`: İzin yönetimi

## 🐛 Bilinen Sorunlar

- Web platformunda Bluetooth desteği sınırlıdır
- iOS'ta Bluetooth bağlantısı için konum izni gereklidir

## 🤝 Katkıda Bulunma

Pull request'ler memnuniyetle karşılanır. Büyük değişiklikler için lütfen önce bir issue açın.

## 📝 Lisans

Bu proje açık kaynaklıdır ve [MIT lisansı](LICENSE) altında sunulmaktadır.

## 👨‍💻 Geliştirici

Mustafa Özkaya

## 🙏 Teşekkürler

- ESP32 topluluğu
- Flutter topluluğu
- Figma tasarım desteği

---

**Not**: ESP32 bağlı değilken uygulama otomatik olarak demo moduna geçer ve dinamik mock veriler gösterir. Bu sayede ESP32'niz hazır olmadan uygulamayı test edebilirsiniz.

