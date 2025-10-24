import 'package:flutter/foundation.dart';

enum AppLanguage { tr, en, de, zh }

class SettingsProvider with ChangeNotifier {
  AppLanguage _language = AppLanguage.tr; // varsayılan Türkçe

  AppLanguage get language => _language;

  void setLanguage(AppLanguage lang) {
    if (_language == lang) return;
    _language = lang;
    notifyListeners();
  }
}
