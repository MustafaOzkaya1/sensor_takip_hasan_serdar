/*
 * ESP32 Sensör BLE Server
 * 
 * Bu kod ESP32'yi BLE sunucusu olarak yapılandırır ve sensör verilerini yayınlar.
 * 
 * Gerekli Kütüphaneler:
 * - BLE Device (ESP32 ile birlikte gelir)
 * - Adafruit BME280 (Sıcaklık, nem, basınç sensörü için)
 * 
 * Bağlantılar:
 * BME280 -> ESP32
 * VCC -> 3.3V
 * GND -> GND
 * SCL -> GPIO 22
 * SDA -> GPIO 21
 */

#include <BLEDevice.h>
#include <BLEServer.h>
#include <BLEUtils.h>
#include <BLE2902.h>
#include <Wire.h>
#include <Adafruit_Sensor.h>
#include <Adafruit_BME280.h>

// BLE UUID'ler (Flutter uygulaması ile aynı olmalı)
#define SERVICE_UUID        "4fafc201-1fb5-459e-8fcc-c5c9c331914b"
#define CHARACTERISTIC_UUID "beb5483e-36e1-4688-b7f5-ea07361b26a8"

// BME280 sensörü
Adafruit_BME280 bme;

// BLE nesneleri
BLEServer* pServer = NULL;
BLECharacteristic* pCharacteristic = NULL;
bool deviceConnected = false;
bool oldDeviceConnected = false;

// Bağlantı durumu callback
class MyServerCallbacks: public BLEServerCallbacks {
    void onConnect(BLEServer* pServer) {
      deviceConnected = true;
      Serial.println("Cihaz bağlandı");
    };

    void onDisconnect(BLEServer* pServer) {
      deviceConnected = false;
      Serial.println("Cihaz bağlantısı kesildi");
    }
};

void setup() {
  Serial.begin(115200);
  Serial.println("ESP32 Sensör BLE Server başlatılıyor...");

  // BME280 sensörünü başlat
  if (!bme.begin(0x76)) {  // Alternatif adres: 0x77
    Serial.println("BME280 sensörü bulunamadı!");
    // Sensör yoksa mock veri gönder
  } else {
    Serial.println("BME280 sensörü başarıyla başlatıldı");
  }

  // BLE cihazını oluştur
  BLEDevice::init("ESP32_Sensor");

  // BLE sunucusunu oluştur
  pServer = BLEDevice::createServer();
  pServer->setCallbacks(new MyServerCallbacks());

  // BLE servisini oluştur
  BLEService *pService = pServer->createService(SERVICE_UUID);

  // BLE karakteristiğini oluştur
  pCharacteristic = pService->createCharacteristic(
                      CHARACTERISTIC_UUID,
                      BLECharacteristic::PROPERTY_READ   |
                      BLECharacteristic::PROPERTY_WRITE  |
                      BLECharacteristic::PROPERTY_NOTIFY |
                      BLECharacteristic::PROPERTY_INDICATE
                    );

  // Descriptor ekle
  pCharacteristic->addDescriptor(new BLE2902());

  // Servisi başlat
  pService->start();

  // Reklamı başlat
  BLEAdvertising *pAdvertising = BLEDevice::getAdvertising();
  pAdvertising->addServiceUUID(SERVICE_UUID);
  pAdvertising->setScanResponse(false);
  pAdvertising->setMinPreferred(0x0);
  BLEDevice::startAdvertising();
  
  Serial.println("BLE servisi başlatıldı, bağlantı bekleniyor...");
}

void loop() {
  // Cihaz bağlandıysa veri gönder
  if (deviceConnected) {
    // Sensör verilerini oku
    float temperature = bme.readTemperature();
    float humidity = bme.readHumidity();
    float pressure = bme.readPressure() / 100.0F; // Pa'dan hPa'ya çevir

    // Mock veri kullan (BME280 yoksa)
    if (isnan(temperature) || isnan(humidity) || isnan(pressure)) {
      temperature = 24.0 + (random(-10, 10) / 10.0);
      humidity = 50.0 + (random(-50, 50) / 10.0);
      pressure = 1013.0 + (random(-10, 10) / 10.0);
    }

    // Veriyi string formatına çevir: "24.00,47.50,1012.50"
    char dataStr[50];
    sprintf(dataStr, "%.2f,%.2f,%.2f", temperature, humidity, pressure);
    
    // BLE ile gönder
    pCharacteristic->setValue(dataStr);
    pCharacteristic->notify();
    
    Serial.print("Gönderilen veri: ");
    Serial.println(dataStr);
    
    delay(2000); // 2 saniye bekle
  }

  // Bağlantı durumu değiştiyse
  if (!deviceConnected && oldDeviceConnected) {
    delay(500);
    pServer->startAdvertising();
    Serial.println("Reklam yeniden başlatıldı");
    oldDeviceConnected = deviceConnected;
  }
  
  if (deviceConnected && !oldDeviceConnected) {
    oldDeviceConnected = deviceConnected;
  }
}

