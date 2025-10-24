import 'package:flutter/foundation.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import '../models/sensor_data.dart';
import '../services/esp32_service.dart';

class SensorProvider with ChangeNotifier {
  final ESP32Service _esp32Service = ESP32Service();

  SensorData? _latestData;
  bool _isConnected = false;
  bool _temperatureSensorEnabled = true;
  bool _pressureSensorEnabled = true;
  BluetoothAdapterState _bluetoothState = BluetoothAdapterState.unknown;
  String? _lastError;

  SensorData? get latestData => _latestData;
  bool get isConnected => _isConnected;
  bool get isUsingMockData => _esp32Service.isUsingMockData;
  bool get temperatureSensorEnabled => _temperatureSensorEnabled;
  bool get pressureSensorEnabled => _pressureSensorEnabled;
  BluetoothAdapterState get bluetoothState => _bluetoothState;
  String? get lastError => _lastError;

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

    // Bluetooth durumunu dinle
    FlutterBluePlus.adapterState.listen((state) {
      _bluetoothState = state;
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
      _lastError = null;
      final devices = await _esp32Service.scanForDevices();
      if (devices.isNotEmpty) {
        await _esp32Service.connectToDevice(devices.first);
      } else {
        _lastError = 'Cihaz bulunamadı';
        notifyListeners();
      }
    } catch (e) {
      _lastError = 'Bağlantı hatası: $e';
      notifyListeners();
    }
  }

  Future<void> disconnect() async {
    await _esp32Service.disconnect();
  }

  // ESP32 kontrol placeholderları
  Future<void> restartESP32() async {
    _lastError = 'Henüz uygulanmadı';
    notifyListeners();
  }

  Future<void> clearErrors() async {
    _lastError = null;
    notifyListeners();
  }

  @override
  void dispose() {
    _esp32Service.dispose();
    super.dispose();
  }
}
