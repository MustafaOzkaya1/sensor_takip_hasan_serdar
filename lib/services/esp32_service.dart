import 'dart:async';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import '../models/sensor_data.dart';

/// ESP32 BLE bağlantısını yöneten servis
class ESP32Service {
  static const String serviceUUID = "4fafc201-1fb5-459e-8fcc-c5c9c331914b";
  static const String characteristicUUID =
      "beb5483e-36e1-4688-b7f5-ea07361b26a8";

  BluetoothDevice? _connectedDevice;

  final _connectionStateController = StreamController<bool>.broadcast();
  final _dataController = StreamController<SensorData>.broadcast();

  Stream<bool> get connectionState => _connectionStateController.stream;
  Stream<SensorData> get dataStream => _dataController.stream;

  bool get isConnected => _connectedDevice != null;

  ESP32Service() {
    _init();
  }

  void _init() {
    // Başlangıçta bağlı değil
    _connectionStateController.add(false);
  }

  /// ESP32 cihazlarını tara
  Future<List<BluetoothDevice>> scanForDevices({
    Duration timeout = const Duration(seconds: 4),
  }) async {
    try {
      if (await FlutterBluePlus.isSupported == false) {
        throw Exception('Bluetooth bu cihazda desteklenmiyor');
      }

      final devices = <BluetoothDevice>[];

      await FlutterBluePlus.startScan(timeout: timeout);

      FlutterBluePlus.scanResults.listen((results) {
        for (var result in results) {
          if (result.device.name.isNotEmpty &&
              result.device.name.contains('ESP32')) {
            if (!devices.contains(result.device)) {
              devices.add(result.device);
            }
          }
        }
      });

      await Future.delayed(timeout);
      await FlutterBluePlus.stopScan();

      return devices;
    } catch (e) {
      print('Scan hatası: $e');
      return [];
    }
  }

  /// ESP32'ye bağlan
  Future<void> connectToDevice(BluetoothDevice device) async {
    try {
      await device.connect();
      _connectedDevice = device;

      // Servisleri keşfet
      final services = await device.discoverServices();

      for (var service in services) {
        if (service.uuid.toString().toLowerCase() ==
            serviceUUID.toLowerCase()) {
          for (var char in service.characteristics) {
            if (char.uuid.toString().toLowerCase() ==
                characteristicUUID.toLowerCase()) {
              // Bildirimleri aç
              await char.setNotifyValue(true);

              // Veri dinle
              char.value.listen((value) {
                if (value.isNotEmpty) {
                  try {
                    final dataString = String.fromCharCodes(value).trim();
                    print('[BLE RAW] "$dataString"');
                    final sensorData = SensorData.fromString(dataString);
                    print('[BLE PARSED] $sensorData');
                    _dataController.add(sensorData);
                  } catch (e) {
                    print('Veri parse hatası: $e');
                  }
                }
              });

              _connectionStateController.add(true);
              print('ESP32\'ye başarıyla bağlandı');
              return;
            }
          }
        }
      }

      throw Exception('ESP32 servisi bulunamadı');
    } catch (e) {
      print('Bağlantı hatası: $e');
      await disconnect();
      rethrow;
    }
  }

  /// Bağlantıyı kes
  Future<void> disconnect() async {
    await _connectedDevice?.disconnect();
    _connectedDevice = null;
    _connectionStateController.add(false);
  }

  void dispose() {
    _connectionStateController.close();
    _dataController.close();
    disconnect();
  }
}
