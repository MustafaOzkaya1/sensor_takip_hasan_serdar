import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ResponsiveSensorCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final bool isEnabled;
  final VoidCallback onToggle;

  const ResponsiveSensorCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.isEnabled,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 400;
    
    // Responsive boyutlar
    final cardWidth = isSmallScreen ? screenWidth - 24 : 169.0;
    final cardHeight = isSmallScreen ? 180.0 : 198.0;
    final iconSize = isSmallScreen ? 20.0 : 24.0;
    final fontSize = isSmallScreen ? 28.0 : 32.0;
    final titleFontSize = isSmallScreen ? 11.0 : 12.0;
    final padding = isSmallScreen ? 16.0 : 20.0;

    return Container(
      width: cardWidth,
      height: cardHeight,
      decoration: BoxDecoration(
        color: const Color(0xFF282424),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // İkon ve Değer
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Değer - Flexible ile esnek hale getir
                Flexible(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      value,
                      style: GoogleFonts.manrope(
                        fontSize: fontSize,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFFF8F8F8),
                        height: 1.375,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                // İkon
                Icon(icon, color: const Color(0xFFF8F8F8), size: iconSize),
              ],
            ),

            const SizedBox(height: 12),

            // Başlık
            Text(
              title,
              style: GoogleFonts.manrope(
                fontSize: titleFontSize,
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
                    fontSize: titleFontSize,
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
                    width: isSmallScreen ? 45 : 50,
                    height: isSmallScreen ? 24 : 26,
                    decoration: BoxDecoration(
                      color: isEnabled
                          ? const Color(0xFFFFB267)
                          : const Color(0xFF393535),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: AnimatedAlign(
                      duration: const Duration(milliseconds: 200),
                      alignment:
                          isEnabled ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 3),
                        width: isSmallScreen ? 18 : 20,
                        height: isSmallScreen ? 18 : 20,
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

