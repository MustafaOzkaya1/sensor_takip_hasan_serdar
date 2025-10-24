import 'dart:async';
import 'dart:math';
import '../models/sensor_data.dart';

/// Mock sensör servisi - ESP32 bağlı olmadığında test için kullanılır
class MockSensorService {
  final _random = Random();
  Timer? _timer;
  final _dataController = StreamController<SensorData>.broadcast();

  // Başlangıç değerleri
  double _currentTemp = 24.0;
  double _currentHumidity = 47.5;
  double _currentPressure = 1012.5;

  Stream<SensorData> get dataStream => _dataController.stream;

  /// Mock veri üretimini başlat
  void startGeneratingData() {
    _timer?.cancel();

    // Her 2 saniyede bir yeni veri üret
    _timer = Timer.periodic(const Duration(seconds: 2), (_) {
      _generateNextData();
    });
  }

  /// Bir sonraki veriyi üret (gerçekçi değişimlerle)
  void _generateNextData() {
    // Sıcaklık: Yavaş değişim (±0.1°C)
    _currentTemp += (_random.nextDouble() - 0.5) * 0.2;
    _currentTemp = _currentTemp.clamp(20.0, 30.0);

    // Nem: Orta hızda değişim (±0.5%)
    _currentHumidity += (_random.nextDouble() - 0.5) * 1.0;
    _currentHumidity = _currentHumidity.clamp(40.0, 60.0);

    // Basınç: Çok yavaş değişim (±0.1 hPa)
    _currentPressure += (_random.nextDouble() - 0.5) * 0.2;
    _currentPressure = _currentPressure.clamp(1010.0, 1015.0);

    final data = SensorData(
      temperature: double.parse(_currentTemp.toStringAsFixed(2)),
      humidity: double.parse(_currentHumidity.toStringAsFixed(2)),
      pressure: double.parse(_currentPressure.toStringAsFixed(2)),
      timestamp: DateTime.now(),
    );

    _dataController.add(data);
  }

  /// Servisi durdur
  void dispose() {
    _timer?.cancel();
    _dataController.close();
  }
}
