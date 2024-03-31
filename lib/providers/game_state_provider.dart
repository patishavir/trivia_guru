import 'package:flutter/material.dart';
import '../common/logging_utils.dart';

enum GameStateEnum { displayQuestion, displayAnswer, clickNextButton, gameOver }

class GameStateProvider {
  var _gameState = GameStateEnum.displayQuestion;

  GameStateEnum get gameState {
    LoggingUtils.writeLog("gameState: $_gameState");
    return _gameState;
  }

  void setGameState (GameStateEnum gameStateParam) {
    _gameState = gameStateParam;
    LoggingUtils.writeLog("set _gameState to $gameStateParam  notifyListeners has been called !");
  }
}
