import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import '../providers/sensor_provider.dart';
import '../widgets/sensor_card.dart';
import '../l10n/l10n.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double s = (size.width / 390).clamp(0.8, 1.6).toDouble();
    return Scaffold(
      backgroundColor: const Color(0xFF211D1D),
      body: Stack(
        children: [
          // Arka plan görseli - Büyütülmüş ve konumlandırılmış
          Positioned(
            top: -30 + (20 * (s - 1)),
            left: -100 + (30 * (s - 1)),
            child: Image.asset(
              'images/Image_fx (48) 1 (1).png',
              width: 650 * s,
              height: 600 * s,
              fit: BoxFit.cover,
            ),
          ),

          // Gradient overlay
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: size.height * 0.55,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    const Color(0xFF211D1D),
                    const Color(0xFF211D1D).withOpacity(0),
                  ],
                  stops: const [0.0, 0.16],
                ),
              ),
            ),
          ),

          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: size.height * 0.55,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    const Color(0xFF190A06).withOpacity(0.5),
                    const Color(0xFF190A06).withOpacity(0),
                  ],
                  stops: const [0.15, 0.33],
                ),
              ),
            ),
          ),

          // İçerik - SafeArea ve SingleChildScrollView ile
          SafeArea(
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight:
                      MediaQuery.of(context).size.height -
                      MediaQuery.of(context).padding.top -
                      MediaQuery.of(context).padding.bottom,
                ),
                child: Column(
                  children: [
                    // NavBar
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20 * s,
                        vertical: 16 * s,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(width: 24 * s), // Sol boşluk
                          Text(
                            S.of(context).controlPanel,
                            style: GoogleFonts.manrope(
                              fontSize: 17 * s,
                              fontWeight: FontWeight.w800,
                              color: const Color(0xFFF8F8F8),
                              height: 1.41,
                            ),
                          ),
                          SizedBox(width: 24 * s),
                        ],
                      ),
                    ),

                    // Bluetooth uyarı bandı (başlığın hemen altında)
                    Consumer<SensorProvider>(
                      builder: (context, prov, _) {
                        final btOff =
                            prov.bluetoothState != BluetoothAdapterState.on;
                        if (!btOff) return const SizedBox.shrink();
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20 * s),
                          child: Container(
                            padding: EdgeInsets.all(12 * s),
                            decoration: BoxDecoration(
                              color: Colors.red.withOpacity(0.12),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: Colors.redAccent.withOpacity(0.4),
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.bluetooth_disabled,
                                  color: Colors.redAccent,
                                  size: 20 * s,
                                ),
                                SizedBox(width: 8 * s),
                                Expanded(
                                  child: Text(
                                    S.of(context).bluetoothOff,
                                    style: GoogleFonts.manrope(
                                      color: const Color(0xFFF8F8F8),
                                      fontSize: 12 * s,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),

                    SizedBox(height: 150),

                    // Sensor Kartları
                    Consumer<SensorProvider>(
                      builder: (context, provider, child) {
                        final data = provider.latestData;

                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20 * s),
                          child: Row(
                            children: [
                              // Sıcaklık Kartı
                              Expanded(
                                child: SensorCard(
                                  title: S.of(context).temperatureData,
                                  value:
                                      data != null
                                          ? '${data.temperature.toStringAsFixed(1)} C°'
                                          : '-- C°',
                                  icon: Icons.thermostat_outlined,
                                  isEnabled: provider.temperatureSensorEnabled,
                                  onToggle: provider.toggleTemperatureSensor,
                                ),
                              ),
                              SizedBox(width: 16 * s),
                              // Basınç Kartı
                              Expanded(
                                child: SensorCard(
                                  title: S.of(context).pressureData,
                                  value:
                                      data != null
                                          ? '${(data.pressure / 1013 * 100).toStringAsFixed(0)}%'
                                          : '--%',
                                  icon: Icons.speed_outlined,
                                  isEnabled: provider.pressureSensorEnabled,
                                  onToggle: provider.togglePressureSensor,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),

                    SizedBox(height: 16 * s),

                    // Light (Nem) Kartı
                    Consumer<SensorProvider>(
                      builder: (context, provider, child) {
                        final data = provider.latestData;

                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20 * s),
                          child: Container(
                            width: double.infinity,
                            height: 154 * s,
                            decoration: BoxDecoration(
                              color: const Color(0xFF282424),
                              borderRadius: BorderRadius.circular(24 * s),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(20 * s),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            S.of(context).humidity,
                                            style: GoogleFonts.manrope(
                                              fontSize: 16 * s,
                                              fontWeight: FontWeight.w600,
                                              color: const Color(0xFFF8F8F8),
                                            ),
                                          ),
                                          SizedBox(height: 8 * s),
                                          FittedBox(
                                            fit: BoxFit.scaleDown,
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              data != null
                                                  ? '${data.humidity.toStringAsFixed(1)}%'
                                                  : '--%',
                                              style: GoogleFonts.manrope(
                                                fontSize: 48 * s,
                                                fontWeight: FontWeight.w500,
                                                color: const Color(0xFFF8F8F8),
                                                height: 1.0,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Icon(
                                        Icons.water_drop_outlined,
                                        color: const Color(
                                          0xFFF8F8F8,
                                        ).withOpacity(0.8),
                                        size: 48 * s,
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  // Bağlantı durumu göstergesi
                                  Row(
                                    children: [
                                      Container(
                                        width: 8 * s,
                                        height: 8 * s,
                                        decoration: BoxDecoration(
                                          color:
                                              provider.isUsingMockData
                                                  ? Colors.orange
                                                  : Colors.green,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      SizedBox(width: 8 * s),
                                      Text(
                                        provider.isUsingMockData
                                            ? S.of(context).demoMode
                                            : S.of(context).esp32Connected,
                                        style: GoogleFonts.manrope(
                                          fontSize: 12 * s,
                                          fontWeight: FontWeight.w400,
                                          color: const Color(
                                            0xFFF8F8F8,
                                          ).withOpacity(0.6),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),

                    SizedBox(height: 20 * s),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
