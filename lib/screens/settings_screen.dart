import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/settings_provider.dart';
import '../providers/sensor_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../l10n/l10n.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final s = MediaQuery.of(context).size.width / 390;
    return Scaffold(
      backgroundColor: const Color(0xFF211D1D),
      appBar: AppBar(
        backgroundColor: const Color(0xFF211D1D),
        elevation: 0,
        title: Text(
          S.of(context).settings,
          style: GoogleFonts.manrope(
            fontSize: 18 * s,
            fontWeight: FontWeight.w700,
            color: const Color(0xFFF8F8F8),
          ),
        ),
        iconTheme: const IconThemeData(color: Color(0xFFF8F8F8)),
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(20 * s),
          children: [
            // Dil Seçimi
            Text(
              S.of(context).language,
              style: GoogleFonts.manrope(
                fontSize: 14 * s,
                fontWeight: FontWeight.w600,
                color: const Color(0xFFF8F8F8),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF282424),
                borderRadius: BorderRadius.circular(12),
              ),
              padding: EdgeInsets.symmetric(horizontal: 12 * s),
              child: Consumer<SettingsProvider>(
                builder: (context, settings, _) {
                  return DropdownButton<AppLanguage>(
                    value: settings.language,
                    isExpanded: true,
                    dropdownColor: const Color(0xFF282424),
                    iconEnabledColor: const Color(0xFFF8F8F8),
                    underline: const SizedBox.shrink(),
                    style: GoogleFonts.manrope(color: const Color(0xFFF8F8F8)),
                    items: [
                      DropdownMenuItem(
                        value: AppLanguage.tr,
                        child: Text(S.of(context).language_tr),
                      ),
                      DropdownMenuItem(
                        value: AppLanguage.en,
                        child: Text(S.of(context).language_en),
                      ),
                      DropdownMenuItem(
                        value: AppLanguage.de,
                        child: Text(S.of(context).language_de),
                      ),
                      DropdownMenuItem(
                        value: AppLanguage.zh,
                        child: Text(S.of(context).language_zh),
                      ),
                    ],
                    onChanged: (val) {
                      if (val != null) settings.setLanguage(val);
                    },
                  );
                },
              ),
            ),

            const SizedBox(height: 24),

            // ESP32 Kontrol
            Text(
              S.of(context).esp32Controls,
              style: GoogleFonts.manrope(
                fontSize: 14 * s,
                fontWeight: FontWeight.w600,
                color: const Color(0xFFF8F8F8),
              ),
            ),
            const SizedBox(height: 8),
            Consumer<SensorProvider>(
              builder: (context, sensor, _) {
                return Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF282424),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: EdgeInsets.all(16 * s),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            sensor.isConnected
                                ? Icons.bluetooth_connected
                                : Icons.bluetooth_disabled,
                            color:
                                sensor.isConnected
                                    ? Colors.green
                                    : Colors.redAccent,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            sensor.isConnected
                                ? S.of(context).connected
                                : S.of(context).notConnected,
                            style: GoogleFonts.manrope(
                              color: const Color(0xFFF8F8F8),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 12,
                        runSpacing: 8,
                        children: [
                          ElevatedButton.icon(
                            onPressed: sensor.scanAndConnect,
                            icon: const Icon(Icons.search),
                            label: Text(S.of(context).scanAndConnect),
                          ),
                          ElevatedButton.icon(
                            onPressed: sensor.disconnect,
                            icon: const Icon(Icons.link_off),
                            label: Text(S.of(context).disconnect),
                          ),
                          ElevatedButton.icon(
                            onPressed: sensor.restartESP32,
                            icon: const Icon(Icons.restart_alt),
                            label: Text(S.of(context).restartESP32),
                          ),
                          ElevatedButton.icon(
                            onPressed: sensor.clearErrors,
                            icon: const Icon(Icons.cleaning_services_outlined),
                            label: Text(S.of(context).clearErrors),
                          ),
                        ],
                      ),
                      if (sensor.lastError != null) ...[
                        const SizedBox(height: 12),
                        Text(
                          'Hata: ${sensor.lastError}',
                          style: GoogleFonts.manrope(color: Colors.orange),
                        ),
                      ],
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
