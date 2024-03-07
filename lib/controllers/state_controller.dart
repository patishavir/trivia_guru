import 'package:get/get.dart';
import '../common/logging_utils.dart';

enum GameState {
  displayQuestion,
  displayAnswer,
  clickNextButton,
  gameOver
}

class StateController extends GetxController {
  var _gameState = GameState.displayQuestion.obs;
  int _currentQuestionIndex = 0;

   get gameState {
    LoggingUtils.writeLog("state_controller get _gameState: ${_gameState.value} !");
    return _gameState.value;
  }

  set setGameState(GameState gameState) {
    _gameState = gameState.obs;
    LoggingUtils.writeLog("state_controller _gameState set to  ${_gameState.value} !");
  }

  int get currentQuestionIndex => _currentQuestionIndex;

  void incrementCurrentQuestionIndex() {
    _currentQuestionIndex++;
    LoggingUtils.writeLog(
        "state_controller _currentQuestionIndex has been incremented to $_currentQuestionIndex !");
  }
}