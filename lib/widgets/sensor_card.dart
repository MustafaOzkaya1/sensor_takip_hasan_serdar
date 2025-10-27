import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SensorCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const SensorCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 169 / 198,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final double scale = (constraints.maxWidth / 169).clamp(0.7, 2.0);
          final double padding = 20 * scale;
          final double titleFont = 12 * scale;
          final double valueFont = 32 * scale;
          final double iconSize = 24 * scale;
          final double spacerTop = 12 * scale;
          final double radius = 24 * scale;

          return Container(
            decoration: BoxDecoration(
              color: const Color(0xFF282424),
              borderRadius: BorderRadius.circular(radius),
            ),
            child: Padding(
              padding: EdgeInsets.all(padding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: FittedBox(
                          alignment: Alignment.centerLeft,
                          fit: BoxFit.scaleDown,
                          child: Text(
                            value,
                            style: GoogleFonts.manrope(
                              fontSize: valueFont,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFFF8F8F8),
                              height: 1.2,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 8 * scale),
                      Icon(
                        icon,
                        color: const Color(0xFFF8F8F8),
                        size: iconSize,
                      ),
                    ],
                  ),

                  SizedBox(height: spacerTop),

                  Text(
                    title,
                    style: GoogleFonts.manrope(
                      fontSize: titleFont,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFFF8F8F8).withOpacity(0.6),
                      letterSpacing: 0.12 * scale,
                      height: 1.2,
                    ),
                  ),

                  const Spacer(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
