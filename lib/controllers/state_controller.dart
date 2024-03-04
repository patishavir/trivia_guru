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
  var gameState = GameState.initial.obs;
  int _currentQuestionIndex = 0;

  GameState get gameStatee {
    LoggingUtils.writeLog("got _gameState: $gameState.value !");
    return gameState.value;
  }

  set setGameState(GameState gameStateee) {
    gameState = gameStateee.obs;
    LoggingUtils.writeLog("_gameState set to  $gameState.value !");
  }

  int get currentQuestionIndex => _currentQuestionIndex;

  void incrementCurrentQuestionIndex() {
    _currentQuestionIndex++;
    LoggingUtils.writeLog(
        "_currentQuestionIndex has been incremented to $_currentQuestionIndex.value !");
  }
}