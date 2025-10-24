import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'providers/sensor_provider.dart';
import 'providers/settings_provider.dart';
import 'screens/root_screen.dart';
import 'l10n/l10n.dart';

Locale _localeFrom(AppLanguage lang) {
  switch (lang) {
    case AppLanguage.tr:
      return const Locale('tr');
    case AppLanguage.en:
      return const Locale('en');
    case AppLanguage.de:
      return const Locale('de');
    case AppLanguage.zh:
      return const Locale('zh');
  }
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Color(0xFF211D1D),
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SensorProvider()),
        ChangeNotifierProvider(create: (_) => SettingsProvider()),
      ],
      child: Consumer<SettingsProvider>(
        builder: (context, settings, _) {
          return MaterialApp(
            title: 'Sensör Takip Uygulaması',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              useMaterial3: true,
              colorScheme: ColorScheme.fromSeed(
                seedColor: const Color(0xFFFFB267),
                brightness: Brightness.dark,
              ),
              scaffoldBackgroundColor: const Color(0xFF211D1D),
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFB267),
                ),
              ),
            ),
            localizationsDelegates: [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.supportedLocales,
            locale: _localeFrom(settings.language),
            home: const RootScreen(),
          );
        },
      ),
    );
  }
}
