import 'package:flutter/material.dart';
import '../../../trivia_guru_projects/trivia_guru/lib/common/logging_utils.dart';

class ScoreProvider extends ChangeNotifier {
  int _correctAnswers = 0;
  int _wrongAnswers = 0;

  int get correctAnswers => _correctAnswers;
  int get wrongAnswers => _wrongAnswers;

  void incrementCorrectAnswers() {
    _correctAnswers++;
    LoggingUtils.writeLog("_correctAnswers incremented to $_correctAnswers !");
    notifyListeners();
  }

  void incrementWrongAnswers() {
    _wrongAnswers++;
    LoggingUtils.writeLog("_wrongAnswers incremented to $_wrongAnswers !");
    notifyListeners();
  }

  void resetCorrectAnswers() {
    _correctAnswers = 0;
    LoggingUtils.writeLog("_wrongAnswers has been reset to $_correctAnswers !");
    notifyListeners();
  }

  void resetWrongAnswers() {
    _wrongAnswers = 0;
    LoggingUtils.writeLog("_wrongAnswers has been reset to $_wrongAnswers !");
    notifyListeners();
  }
}
