import 'package:get/get.dart';
import '../common/logging_utils.dart';

enum GameState {
  initialState,
  displayQuestion,
  displayAnswer,
  gameOver
}

class StatusController extends GetxController {

  var _gameState = GameState.initialState.obs;
  get gameState {
    LoggingUtils.writeLog("got _gameState: $_gameState.value !");
    _gameState.value;
  }
  set setGameState (GameState gstate) {
    _gameState = gstate.obs;
    LoggingUtils.writeLog("_gameState set to  $_gameState.value !");
  }
  var _currentQuestionIndex = 0.obs;

  int get currentQuestionIndex => _currentQuestionIndex.value;

   void incrementCurrentQuestionIndex () {
    int cIndex = _currentQuestionIndex.value ;
    cIndex ++;
    _currentQuestionIndex = cIndex.obs ;
    LoggingUtils.writeLog("_currentQuestionIndex has been incremented to $_currentQuestionIndex.value !");
  }
}
