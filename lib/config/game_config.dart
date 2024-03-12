import 'package:flutter/material.dart';
import 'package:trivia_guru/utils/questions_utils.dart';

class GameConfig {
  static const bool writeLog = true;
  static const int answersCount = 4;
  static const double fontSize = 20.0;
  // static const String fontFamily = "NovaSlim";
  static const String fontFamily = "gadi-almog";
  static int questionsPerGame = QuestionsUtils.questionsList.length;
  static const int confettiAnimationDuration = 3;
  static const TextDirection textDirection = TextDirection.rtl;
  static const Locale defaultLocale = Locale("he");
  static const String questionsFilePath ="assets/questions/q3.json";
  static const String imagesFolderFilePath ="assets/images";
}
