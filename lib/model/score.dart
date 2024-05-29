import 'package:trivia_guru/model/ScoreHistory.dart';
import 'package:common_code/common_code.dart';

class Score {
  static int _correctAnswers = 0;
  static int _wrongAnswers = 0;

  static int get correctAnswers => _correctAnswers;
  static int get wrongAnswers => _wrongAnswers;

  static final List<ScoreHistory> _scoreHistoryList = [];

  static void incrementCorrectAnswers() {
    _correctAnswers++;
    LoggingUtils.writeLog("_correctAnswers incremented to $_correctAnswers !");
  }

  static void incrementWrongAnswers() {
    _wrongAnswers++;
    LoggingUtils.writeLog("_wrongAnswers incremented to $_wrongAnswers !");
  }

  static void resetCorrectAnswers() {
    _correctAnswers = 0;
    LoggingUtils.writeLog("_wrongAnswers has been reset to $_correctAnswers !");
  }

  static void resetWrongAnswers() {
    _wrongAnswers = 0;
    LoggingUtils.writeLog("_wrongAnswers has been reset to $_wrongAnswers !");
  }
  static void addToHistory ( ScoreHistory scoreHistory) {
    _scoreHistoryList.add(scoreHistory);
  }
}