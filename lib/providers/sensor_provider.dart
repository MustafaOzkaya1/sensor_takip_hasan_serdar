import 'package:flutter/foundation.dart';
import '../models/sensor_data.dart';
import '../services/esp32_service.dart';

class SensorProvider with ChangeNotifier {
  final ESP32Service _esp32Service = ESP32Service();

  SensorData? _latestData;
  bool _isConnected = false;
  bool _temperatureSensorEnabled = true;
  bool _pressureSensorEnabled = true;

  SensorData? get latestData => _latestData;
  bool get isConnected => _isConnected;
  bool get isUsingMockData => _esp32Service.isUsingMockData;
  bool get temperatureSensorEnabled => _temperatureSensorEnabled;
  bool get pressureSensorEnabled => _pressureSensorEnabled;

  SensorProvider() {
    _init();
  }

  void _init() {
    // Veri akışını dinle
    _esp32Service.dataStream.listen((data) {
      _latestData = data;
      notifyListeners();
    });

    // Bağlantı durumunu dinle
    _esp32Service.connectionState.listen((connected) {
      _isConnected = connected;
      notifyListeners();
    });
  }

  void toggleTemperatureSensor() {
    _temperatureSensorEnabled = !_temperatureSensorEnabled;
    notifyListeners();
  }

  void togglePressureSensor() {
    _pressureSensorEnabled = !_pressureSensorEnabled;
    notifyListeners();
  }

  Future<void> scanAndConnect() async {
    try {
      final devices = await _esp32Service.scanForDevices();
      if (devices.isNotEmpty) {
        await _esp32Service.connectToDevice(devices.first);
      }
    } catch (e) {
      print('Bağlantı hatası: $e');
    }
  }

  Future<void> disconnect() async {
    await _esp32Service.disconnect();
  }

  @override
  void dispose() {
    _esp32Service.dispose();
    super.dispose();
  }
}
