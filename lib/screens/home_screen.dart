import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/sensor_provider.dart';
import '../widgets/responsive_sensor_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.width < 400;
    
    return Scaffold(
      backgroundColor: const Color(0xFF211D1D),
      body: Stack(
        children: [
          // Arka plan görseli - Responsive ve büyütülmüş
          Positioned(
            top: -100, // Daha aşağı
            left: -80, // Daha sağa (pozitif yönde)
            child: Image.asset(
              'images/Image_fx (48) 1 (1).png',
              width: size.width * 1.8, // Ekran genişliğinin 1.8 katı
              height: size.height * 0.7, // Ekran yüksekliğinin 0.7'si
              fit: BoxFit.cover,
            ),
          ),

          // Gradient overlay - Alt kısım için
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: size.height * 0.6,
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

          // Gradient overlay - Üst kısım için
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: size.height * 0.6,
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
                  minHeight: size.height -
                      MediaQuery.of(context).padding.top -
                      MediaQuery.of(context).padding.bottom,
                ),
                child: Column(
                  children: [
                // NavBar
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: isSmallScreen ? 12 : 20,
                    vertical: isSmallScreen ? 12 : 16,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(width: 24), // Sol boşluk
                      Flexible(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            'Kontrol Paneli',
                            style: GoogleFonts.manrope(
                              fontSize: 17,
                              fontWeight: FontWeight.w800,
                              color: const Color(0xFFF8F8F8),
                              height: 1.41,
                            ),
                          ),
                        ),
                      ),
                      // Bildirim ikonu
                      IconButton(
                        icon: const Icon(
                          Icons.notifications_outlined,
                          color: Color(0xFFF8F8F8),
                          size: 24,
                        ),
                        onPressed: () {
                          // Bildirimler sayfasına git
                        },
                      ),
                    ],
                  ),
                ),

                SizedBox(height: isSmallScreen ? 200 : size.height * 0.35),

                // Sensor Kartları - Responsive
                Consumer<SensorProvider>(
                  builder: (context, provider, child) {
                    final data = provider.latestData;

                    return Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: isSmallScreen ? 12 : 20,
                      ),
                      child: isSmallScreen
                          ? Column(
                              children: [
                                // Sıcaklık Kartı
                                ResponsiveSensorCard(
                                  title: 'Sıcaklık\nVerisi',
                                  value:
                                      data != null
                                          ? '${data.temperature.toStringAsFixed(1)} C°'
                                          : '-- C°',
                                  icon: Icons.thermostat_outlined,
                                  isEnabled: provider.temperatureSensorEnabled,
                                  onToggle: provider.toggleTemperatureSensor,
                                ),
                                const SizedBox(height: 12),
                                // Basınç Kartı
                                ResponsiveSensorCard(
                                  title: 'Basınç\nVerisi',
                                  value:
                                      data != null
                                          ? '${(data.pressure / 1013 * 100).toStringAsFixed(0)}%'
                                          : '--%',
                                  icon: Icons.speed_outlined,
                                  isEnabled: provider.pressureSensorEnabled,
                                  onToggle: provider.togglePressureSensor,
                                ),
                              ],
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Sıcaklık Kartı
                                Flexible(
                                  child: ResponsiveSensorCard(
                                    title: 'Sıcaklık\nVerisi',
                                    value:
                                        data != null
                                            ? '${data.temperature.toStringAsFixed(1)} C°'
                                            : '-- C°',
                                    icon: Icons.thermostat_outlined,
                                    isEnabled: provider.temperatureSensorEnabled,
                                    onToggle: provider.toggleTemperatureSensor,
                                  ),
                                ),

                                const SizedBox(width: 12),

                                // Basınç Kartı
                                Flexible(
                                  child: ResponsiveSensorCard(
                                    title: 'Basınç\nVerisi',
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

                const SizedBox(height: 12),

                // Light (Nem) Kartı - Responsive
                Consumer<SensorProvider>(
                  builder: (context, provider, child) {
                    final data = provider.latestData;

                    return Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: isSmallScreen ? 12 : 20,
                      ),
                      child: Container(
                        width: double.infinity,
                        constraints: BoxConstraints(
                          minHeight: isSmallScreen ? 140 : 154,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF282424),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(isSmallScreen ? 16 : 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: Text(
                                            'Nem Oranı',
                                            style: GoogleFonts.manrope(
                                              fontSize: isSmallScreen ? 14 : 16,
                                              fontWeight: FontWeight.w600,
                                              color: const Color(0xFFF8F8F8),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: isSmallScreen ? 4 : 8),
                                        FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: Text(
                                            data != null
                                                ? '${data.humidity.toStringAsFixed(1)}%'
                                                : '--%',
                                            style: GoogleFonts.manrope(
                                              fontSize: isSmallScreen ? 36 : 48,
                                              fontWeight: FontWeight.w500,
                                              color: const Color(0xFFF8F8F8),
                                              height: 1.0,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Icon(
                                    Icons.water_drop_outlined,
                                    color: const Color(
                                      0xFFF8F8F8,
                                    ).withOpacity(0.8),
                                    size: isSmallScreen ? 36 : 48,
                                  ),
                                ],
                              ),
                                  const Spacer(),
                                  // Bağlantı durumu göstergesi
                                  Row(
                                    children: [
                                      Container(
                                        width: 8,
                                        height: 8,
                                        decoration: BoxDecoration(
                                          color:
                                              provider.isUsingMockData
                                                  ? Colors.orange
                                                  : Colors.green,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        provider.isUsingMockData
                                            ? 'Demo Modu'
                                            : 'ESP32 Bağlı',
                                        style: GoogleFonts.manrope(
                                          fontSize: 12,
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

                    const SizedBox(height: 20),

                    // Alt Navigation Bar
                    Container(
                      height: 84,
                      decoration: const BoxDecoration(color: Color(0xFF211D1D)),
                      child: Column(
                        children: [
                          // Tab bar
                          Padding(
                            padding: const EdgeInsets.only(top: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                // Home (aktif)
                                IconButton(
                                  icon: const Icon(
                                    Icons.home,
                                    color: Color(0xFFFFB267),
                                    size: 24,
                                  ),
                                  onPressed: () {},
                                ),
                                // Settings
                                IconButton(
                                  icon: Icon(
                                    Icons.settings_outlined,
                                    color: const Color(
                                      0xFFF8F8F8,
                                    ).withOpacity(0.6),
                                    size: 24,
                                  ),
                                  onPressed: () {},
                                ),
                                // Profile
                                IconButton(
                                  icon: Icon(
                                    Icons.person_outline,
                                    color: const Color(
                                      0xFFF8F8F8,
                                    ).withOpacity(0.6),
                                    size: 24,
                                  ),
                                  onPressed: () {},
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          // Home Indicator
                          Container(
                            width: 134,
                            height: 5,
                            margin: const EdgeInsets.only(bottom: 8),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF8F8F8),
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                        ],
                      ),
                    ),
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
