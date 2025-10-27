import 'package:flutter/material.dart';

class SimpleLineChart extends StatelessWidget {
  final List<double> points;
  final double height;
  final Color lineColor;
  final String title;

  const SimpleLineChart({
    super.key,
    required this.points,
    required this.title,
    this.height = 120,
    this.lineColor = const Color(0xFFFFB267),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: const Color(0xFF282424),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(12),
      child: CustomPaint(
        painter: _LineChartPainter(
          points,
          lineColor,
          title,
          textColor: const Color(0xFFF8F8F8),
        ),
        size: Size.infinite,
      ),
    );
  }
}

class _LineChartPainter extends CustomPainter {
  final List<double> points;
  final Color lineColor;
  final String title;
  final Color textColor;

  _LineChartPainter(
    this.points,
    this.lineColor,
    this.title, {
    required this.textColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final bg =
        Paint()
          ..color = Colors.transparent
          ..style = PaintingStyle.fill;
    canvas.drawRect(Offset.zero & size, bg);

    final gridPaint =
        Paint()
          ..color = Colors.white.withOpacity(0.08)
          ..strokeWidth = 1;

    final rows = 3;
    for (int i = 1; i <= rows; i++) {
      final y = size.height * i / (rows + 1);
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    // Title
    final textPainter = TextPainter(
      text: TextSpan(
        text: title,
        style: TextStyle(
          color: textColor.withOpacity(0.8),
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: size.width);
    textPainter.paint(canvas, const Offset(4, 0));

    if (points.isEmpty) return;

    final minY = points.reduce((a, b) => a < b ? a : b);
    final maxY = points.reduce((a, b) => a > b ? a : b);
    final range = (maxY - minY).abs() < 1e-6 ? 1.0 : (maxY - minY);

    final path = Path();
    for (int i = 0; i < points.length; i++) {
      final x =
          size.width * (i / (points.length - 1).clamp(1, double.infinity));
      final y = size.height - ((points[i] - minY) / range) * (size.height - 18);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    final stroke =
        Paint()
          ..color = lineColor
          ..strokeWidth = 2
          ..style = PaintingStyle.stroke
          ..isAntiAlias = true;

    canvas.drawPath(path, stroke);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
