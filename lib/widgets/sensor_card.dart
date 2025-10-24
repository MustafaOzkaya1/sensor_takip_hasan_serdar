import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SensorCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final bool isEnabled;
  final VoidCallback onToggle;

  const SensorCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.isEnabled,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 169,
      height: 198,
      decoration: BoxDecoration(
        color: const Color(0xFF282424),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // İkon ve Değer
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Değer
                Text(
                  value,
                  style: GoogleFonts.manrope(
                    fontSize: 32,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFFF8F8F8),
                    height: 1.375,
                  ),
                ),
                // İkon
                Icon(icon, color: const Color(0xFFF8F8F8), size: 24),
              ],
            ),

            const SizedBox(height: 12),

            // Başlık
            Text(
              title,
              style: GoogleFonts.manrope(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: const Color(0xFFF8F8F8).withOpacity(0.6),
                letterSpacing: 0.12,
                height: 1.33,
              ),
            ),

            const Spacer(),

            // Çizgi
            Container(height: 1, color: const Color(0xFF393535)),

            const SizedBox(height: 14),

            // Aç/Kapa Switch
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Aç/Kapa',
                  style: GoogleFonts.manrope(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFFF8F8F8).withOpacity(0.6),
                    letterSpacing: 0.12,
                    height: 1.33,
                  ),
                ),
                GestureDetector(
                  onTap: onToggle,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 50,
                    height: 26,
                    decoration: BoxDecoration(
                      color:
                          isEnabled
                              ? const Color(0xFFFFB267)
                              : const Color(0xFF393535),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: AnimatedAlign(
                      duration: const Duration(milliseconds: 200),
                      alignment:
                          isEnabled
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 3),
                        width: 20,
                        height: 20,
                        decoration: const BoxDecoration(
                          color: Color(0xFF282424),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
