import '../common/logging_utils.dart';

class SessionData {
  static int selectedAnswer = 0;
  static int _currentQuestionIndex = 0;

  static int get currentQuestionIndex => _currentQuestionIndex;

  static void initSessionData() {
    selectedAnswer = 0;
  }

  static void incrementCurrentQuestionIndex () {
    _currentQuestionIndex++;
    LoggingUtils.writeLog("_currentQuestionIndex has been incremented to $_currentQuestionIndex !");
  }
}