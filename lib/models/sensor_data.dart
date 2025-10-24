class SensorData {
  final double temperature;
  final double humidity;
  final double pressure;
  final DateTime timestamp;

  SensorData({
    required this.temperature,
    required this.humidity,
    required this.pressure,
    required this.timestamp,
  });

  // ESP32'den gelen string formatını parse et: "24.00,47.50,1012.50"
  factory SensorData.fromString(String data) {
    final parts = data.split(',');
    if (parts.length != 3) {
      throw FormatException('Invalid sensor data format: $data');
    }

    return SensorData(
      temperature: double.parse(parts[0].trim()),
      humidity: double.parse(parts[1].trim()),
      pressure: double.parse(parts[2].trim()),
      timestamp: DateTime.now(),
    );
  }

  @override
  String toString() {
    return 'SensorData(temp: $temperature°C, humidity: $humidity%, pressure: $pressure hPa)';
  }
}
