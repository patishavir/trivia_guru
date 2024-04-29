import 'package:get/get.dart';
import '../common/logging_utils.dart';

enum GameStateEnum {
  displayQuestion,
  displayAnswer,
}

class GameStateController extends GetxController {
  final _gameState = GameStateEnum.displayQuestion.obs;

  GameStateEnum get gameState {
    LoggingUtils.writeLog("get gameState: $_gameState");
    return _gameState.value;
  }

  void setGameState(GameStateEnum gameStateParam) {
    _gameState.value = gameStateParam;
    LoggingUtils.writeLog("set _gameState to $_gameState.value  !");
  }
}
