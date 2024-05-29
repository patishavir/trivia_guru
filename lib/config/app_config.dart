import 'package:flutter/material.dart';

class AppConfig {
  static const String appTitle = "Trivia Guru";
  static const bool multipleChoiceQuestions = false;
  static const int answersCount = 4;
  static const double fontSize = 16.0;
  static const String hebFontFamily = "gadi-almog";
  static const String enFontFamily = "NovaSlim";
  static const int questionsPerGame = 2;
  static const int confettiAnimationDuration = 3;
  static const Locale hebrewIlLocale = Locale('he', 'IL');
  static const Locale englishUsLocale = Locale('en', 'US');
  static const Locale defaultLocale = hebrewIlLocale;
  static const Locale fallbackLocale = englishUsLocale;
  static const Locale currentLocale = hebrewIlLocale;
  // static const Locale currentLocale = englishUsLocale;
  static const String questionsFilePath = "assets/questions/q3.json";
  static const String imagesFolderFilePath = "assets/images";
  static const String iconsFolderFilePath = "assets/icons";
}
