# ESP32 Sensör Kodu

Bu klasör ESP32 mikrodenetleyicisi için BLE sensör sunucusu kodunu içerir.

## 🛠️ Gerekli Malzemeler

1. **ESP32 Development Board** (ESP32-DevKitC veya benzeri)
2. **BME280 Sensör Modülü** (Sıcaklık, Nem, Basınç) - Opsiyonel
3. **Breadboard** (prototipleme için)
4. **Jumper kablolar** (4 adet)
5. **Micro USB kablosu** (ESP32'yi programlamak için)

## 📌 Bağlantı Şeması

```
BME280 Sensörü    ->    ESP32
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
VCC (3.3V)        ->    3V3
GND               ->    GND
SCL               ->    GPIO 22 (SCL)
SDA               ->    GPIO 21 (SDA)
```

### Görsel Bağlantı Rehberi

```
      ESP32                    BME280
   ┌─────────┐             ┌──────────┐
   │         │             │          │
   │   3V3   ├─────────────┤   VCC    │
   │   GND   ├─────────────┤   GND    │
   │  GPIO22 ├─────────────┤   SCL    │
   │  GPIO21 ├─────────────┤   SDA    │
   │         │             │          │
   └─────────┘             └──────────┘
```

## 📚 Gerekli Kütüphaneler

Arduino IDE'de aşağıdaki kütüphaneleri yükleyin:

1. **ESP32 Board Support**
   - Arduino IDE → Dosya → Tercihler
   - Ek Kart Yöneticisi URL'leri: `https://dl.espressif.com/dl/package_esp32_index.json`
   - Araçlar → Kart → Kart Yöneticisi → "ESP32" ara ve yükle

2. **Adafruit BME280 Library**
   - Araçlar → Kütüphane Yöneticisi
   - "Adafruit BME280" ara ve yükle
   - Bağımlılıkları da yükle (Adafruit Unified Sensor)

## 🚀 Kurulum Adımları

### 1. Arduino IDE Kurulumu

```bash
# Arduino IDE'yi indirin ve kurun
# https://www.arduino.cc/en/software
```

### 2. ESP32 Kartını Seçin

```
Araçlar → Kart → ESP32 Arduino → ESP32 Dev Module
```

### 3. Port Seçimi

```
Araçlar → Port → (ESP32'nizin bağlı olduğu portu seçin)
# macOS: /dev/cu.usbserial-*
# Windows: COM3, COM4, vb.
# Linux: /dev/ttyUSB0, /dev/ttyACM0, vb.
```

### 4. Kodu Yükleyin

1. `sensor_ble_server.ino` dosyasını Arduino IDE'de açın
2. Kart ve Port ayarlarını doğrulayın
3. Yükle butonuna tıklayın (→)
4. Yükleme tamamlandığında "Done uploading" mesajını bekleyin

### 5. Seri Monitörü Açın

```
Araçlar → Seri Monitör
Baud Rate: 115200
```

Çıktı:
```
ESP32 Sensör BLE Server başlatılıyor...
BME280 sensörü başarıyla başlatıldı
BLE servisi başlatıldı, bağlantı bekleniyor...
```

## 🔍 Sorun Giderme

### BME280 Bulunamıyor

**Hata**: `BME280 sensörü bulunamadı!`

**Çözümler**:
1. Kablo bağlantılarını kontrol edin
2. BME280 I2C adresini değiştirin:
   ```cpp
   // Kod içinde 34. satırı değiştirin:
   if (!bme.begin(0x76)) {  // Alternatif: 0x77
   ```
3. I2C Scanner kullanarak adresi bulun

### Port Bulunamıyor

**Hata**: Port görünmüyor

**Çözümler**:
1. USB kablosunu kontrol edin (veri destekli kablo olmalı)
2. ESP32 sürücülerini yükleyin:
   - CP2102: https://www.silabs.com/developers/usb-to-uart-bridge-vcp-drivers
   - CH340: http://www.wch.cn/downloads/CH341SER_MAC_ZIP.html
3. USB portunu değiştirmeyi deneyin

### Upload Hatası

**Hata**: `Failed to connect to ESP32`

**Çözümler**:
1. Upload sırasında "BOOT" butonunu basılı tutun
2. Baud rate'i 115200'e düşürün
3. ESP32'yi resetleyin (EN/RST butonu)

## 📊 Veri Formatı

ESP32'den gönderilen veri formatı:
```
24.00,47.50,1012.50
```

- **24.00**: Sıcaklık (°C)
- **47.50**: Nem (%)
- **1012.50**: Basınç (hPa)

## ⚙️ Yapılandırma

### UUID'leri Değiştirme

Kendi UUID'lerinizi kullanmak isterseniz:

```cpp
// sensor_ble_server.ino içinde
#define SERVICE_UUID        "kendi-service-uuid"
#define CHARACTERISTIC_UUID "kendi-characteristic-uuid"
```

⚠️ **Not**: Flutter uygulamasındaki UUID'leri de değiştirmeyi unutmayın!

### Gönderim Sıklığını Değiştirme

```cpp
// loop() fonksiyonunda
delay(2000); // 2000ms = 2 saniye

// Değiştirin:
delay(5000); // 5 saniye için
```

## 🔋 Güç Tüketimi

- **Normal Mod**: ~80-160 mA
- **Deep Sleep**: ~10 µA (kullanılmıyor)

BME280 sensörü çok düşük güç tüketir (~3.6 µA sleep modunda).

## 📝 Mock Veri Modu

BME280 sensörü olmadan test etmek için:

Kod otomatik olarak sensör bulunamazsa mock veri üretir:
```cpp
temperature = 24.0 + (random(-10, 10) / 10.0);
humidity = 50.0 + (random(-50, 50) / 10.0);
pressure = 1013.0 + (random(-10, 10) / 10.0);
```

## 🌐 BLE Ayarları

- **Device Name**: `ESP32_Sensor`
- **Service UUID**: `4fafc201-1fb5-459e-8fcc-c5c9c331914b`
- **Characteristic UUID**: `beb5483e-36e1-4688-b7f5-ea07361b26a8`
- **Update Rate**: 2 saniye
- **Menzil**: ~10-50 metre (ortama bağlı)

## 🔐 Güvenlik

Bu örnek kod temel BLE bağlantısı kullanır. Üretim ortamı için:

1. BLE pairing ekleyin
2. Encryption kullanın
3. Authentication ekleyin

## 📖 Ek Kaynaklar

- [ESP32 BLE Documentation](https://docs.espressif.com/projects/esp-idf/en/latest/esp32/api-reference/bluetooth/esp_gap_ble.html)
- [BME280 Datasheet](https://www.bosch-sensortec.com/media/boschsensortec/downloads/datasheets/bst-bme280-ds002.pdf)
- [Adafruit BME280 Guide](https://learn.adafruit.com/adafruit-bme280-humidity-barometric-pressure-temperature-sensor-breakout)

## ❓ Sık Sorulan Sorular

**S: BME280 olmadan kullanabilir miyim?**  
C: Evet! Kod otomatik olarak mock veri üretir.

**S: Kaç cihaz bağlanabilir?**  
C: Aynı anda 1 cihaz. Çoklu bağlantı için kod değişikliği gerekir.

**S: Menzil ne kadar?**  
C: Normal koşullarda 10-50 metre. Duvarlar ve engeller menzili azaltır.

**S: Pillele çalışır mı?**  
C: Evet! Lipo batarya veya power bank kullanabilirsiniz.

---

**Yardıma mı ihtiyacınız var?** Issue açın veya dokümantasyonu inceleyin.

