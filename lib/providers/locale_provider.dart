import 'package:flutter/material.dart';
import '../config/game_config.dart';
import '../common/logging_utils.dart';

class LocaleProvider extends ChangeNotifier {
  static const Locale hebrewLocale = Locale ("he");
  static const Locale englishLocale = Locale ("en");
  Locale? _locale = hebrewLocale;

  LocaleProvider () {
    _locale = GameConfig.defaultLocale;
    LoggingUtils.writeLog("LocaleModel constructor: _locale is $_locale");
  }
  Locale? get locale => _locale;

   set setLocale(Locale locale) {
    _locale = locale;
    notifyListeners();
  }
}