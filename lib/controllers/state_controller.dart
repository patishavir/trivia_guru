import 'package:get/get.dart';
import '../common/logging_utils.dart';

enum GameState {
  initial,
  displayQuestion,
  displayAnswer,
  clickNextButton,
  gameOver
}

class StateController extends GetxController {
  var _gameState = GameState.initial.obs;
  int _currentQuestionIndex = 0;

  GameState get gameState {
    LoggingUtils.writeLog("got _gameState: $_gameState.value !");
    return _gameState.value;
  }

  set setGameState(GameState gameState) {
    _gameState = gameState.obs;
    LoggingUtils.writeLog("_gameState set to  $_gameState.value !");
  }

  int get currentQuestionIndex => _currentQuestionIndex;

  void incrementCurrentQuestionIndex() {
    _currentQuestionIndex++;
    LoggingUtils.writeLog(
        "_currentQuestionIndex has been incremented to $_currentQuestionIndex.value !");
  }
}