import 'package:flutter/material.dart';

class GameConfig {
  static const bool writeLog = true;
  static const int answersCount = 4;
  static const double fontSize = 20.0;
  static const String hebFontFamily = "gadi-almog";
  static const String enFontFamily = "NovaSlim";
  static const int questionsPerGame = 2;
  static const int confettiAnimationDuration = 3;
  static const TextDirection textDirection = TextDirection.rtl;
  static const Locale hebrewIlLocale = Locale('he', 'IL');
  static const Locale englishUsLocale = Locale('en', 'US');
  static const Locale defaultLocale = hebrewIlLocale;
  static const Locale fallbackLocale = englishUsLocale;
  static const Locale currentLocale = hebrewIlLocale;
  // static const Locale currentLocale = englishUsLocale;
  static const String questionsFilePath = "assets/questions/q3.json";
  static const String imagesFolderFilePath = "assets/images";
}