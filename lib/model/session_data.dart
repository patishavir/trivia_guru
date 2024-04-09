import '../common/logging_utils.dart';

class SessionData {
  static int selectedAnswer = 0;
  static int _currentQuestionIndex = 0;
  static int _currentGameQuestionIndex = 0;
  static int _currentGameNumber = 1;

  static void initSessionData() {
    selectedAnswer = 0;
    _currentGameQuestionIndex = 0;
    _currentGameNumber++;
  }

  static int get currentQuestionIndex => _currentQuestionIndex;
  static int get currentGameQuestionIndex => _currentGameQuestionIndex;
  static int get currentGameNumber => _currentGameNumber;

  static void incrementCurrentQuestionIndex() {
    _currentQuestionIndex++;
    _currentGameQuestionIndex++;
    LoggingUtils.writeLog(
        "state_controller _currentQuestionIndex has been incremented to $_currentQuestionIndex !");
  }
}
