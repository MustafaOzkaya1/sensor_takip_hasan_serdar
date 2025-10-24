import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'home_screen.dart';
import 'settings_screen.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double s = (size.width / 390).clamp(0.8, 1.6).toDouble();

    return Scaffold(
      backgroundColor: const Color(0xFF211D1D),
      body: IndexedStack(
        index: _index,
        children: const [HomeScreen(), SettingsScreen()],
      ),
      bottomNavigationBar: Container(
        height: 84 * s,
        decoration: const BoxDecoration(color: Color(0xFF211D1D)),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 12 * s),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.home,
                      color:
                          _index == 0
                              ? const Color(0xFFFFB267)
                              : Colors.white.withOpacity(0.6),
                      size: 24 * s,
                    ),
                    onPressed: () => setState(() => _index = 0),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.settings_outlined,
                      color:
                          _index == 1
                              ? const Color(0xFFFFB267)
                              : Colors.white.withOpacity(0.6),
                      size: 24 * s,
                    ),
                    onPressed: () => setState(() => _index = 1),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Container(
              width: 134 * s,
              height: 5 * s,
              margin: EdgeInsets.only(bottom: 8 * s),
              decoration: BoxDecoration(
                color: const Color(0xFFF8F8F8),
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
