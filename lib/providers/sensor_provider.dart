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

  // History buffers
  final List<double> _temperatureHistory = <double>[];
  final List<double> _pressureHistory = <double>[];
  static const int _maxPoints = 200;

  SensorData? get latestData => _latestData;
  bool get isConnected => _isConnected;
  bool get temperatureSensorEnabled => _temperatureSensorEnabled;
  bool get pressureSensorEnabled => _pressureSensorEnabled;
  BluetoothAdapterState get bluetoothState => _bluetoothState;
  String? get lastError => _lastError;

  List<double> get temperatureHistory => List.unmodifiable(_temperatureHistory);
  List<double> get pressureHistory => List.unmodifiable(_pressureHistory);

  SensorProvider() {
    _init();
  }

  void _init() {
    _esp32Service.dataStream.listen((data) {
      _latestData = data;
      // Append to histories
      _appendPoint(_temperatureHistory, data.temperature);
      _appendPoint(_pressureHistory, data.pressure);
      notifyListeners();
    });

    _esp32Service.connectionState.listen((connected) {
      _isConnected = connected;
      if (connected) {
        // Reset history when a fresh connection is established
        _temperatureHistory.clear();
        _pressureHistory.clear();
      }
      notifyListeners();
    });

    FlutterBluePlus.adapterState.listen((state) {
      _bluetoothState = state;
      notifyListeners();
    });
  }

  void _appendPoint(List<double> buffer, double value) {
    buffer.add(value);
    if (buffer.length > _maxPoints) {
      buffer.removeAt(0);
    }
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
