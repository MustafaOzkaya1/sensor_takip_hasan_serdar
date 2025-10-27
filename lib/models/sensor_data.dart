class SensorData {
  final double temperature;
  final double? humidity; // optional
  final double pressure;
  final DateTime timestamp;

  SensorData({
    required this.temperature,
    required this.humidity,
    required this.pressure,
    required this.timestamp,
  });

  // ESP32'den gelen string formatını parse et: "22.35,884.58" veya "24.00,47.50,1012.50"
  factory SensorData.fromString(String data) {
    final cleaned = data.trim();
    final parts = cleaned.split(',').map((e) => e.trim()).toList();
    if (parts.length != 2 && parts.length != 3) {
      throw FormatException('Invalid sensor data format: $data');
    }

    double parseDouble(String s) => double.parse(s);

    if (parts.length == 2) {
      // temperature, pressure
      final temperature = parseDouble(parts[0]);
      final pressure = parseDouble(parts[1]);
      return SensorData(
        temperature: temperature,
        humidity: null,
        pressure: pressure,
        timestamp: DateTime.now(),
      );
    } else {
      // temperature, humidity, pressure
      final temperature = parseDouble(parts[0]);
      final humidity = parseDouble(parts[1]);
      final pressure = parseDouble(parts[2]);
      return SensorData(
        temperature: temperature,
        humidity: humidity,
        pressure: pressure,
        timestamp: DateTime.now(),
      );
    }
  }

  @override
  String toString() {
    return 'SensorData(temp: $temperature°C, humidity: ${humidity?.toStringAsFixed(2) ?? '--'}%, pressure: $pressure hPa)';
  }
}
