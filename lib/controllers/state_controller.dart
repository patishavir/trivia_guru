import 'package:get/get.dart';
import '../common/logging_utils.dart';

enum GameStateEnum { displayQuestion, displayAnswer, clickNextButton, gameOver }

class StateController extends GetxController {
  var gameState = GameStateEnum.displayQuestion.obs;
}
