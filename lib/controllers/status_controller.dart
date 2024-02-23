import 'package:get/get.dart';
import '../common/logging_utils.dart';

class StatusController extends GetxController {
  final  _isWaitingForAnAnswer = true.obs;
  bool get isWaitingForAnAnswer => _isWaitingForAnAnswer.value;
  var _currentQuestionIndex = 0.obs;

  int get currentQuestionIndex => _currentQuestionIndex.value;

  void setIsWaitingForAnAnswer(bool isWaitingForAnAnswer) {
    _isWaitingForAnAnswer.value = isWaitingForAnAnswer;
    LoggingUtils.writeLog("isWaitingForAnAnswer is $_isWaitingForAnAnswer.value !");
    update();
    LoggingUtils.writeLog("isWaitingForAnAnswer is: update has been called !");
  }
  void incrementCurrentQuestionIndex () {
    int cIndex = _currentQuestionIndex.value ;
    cIndex ++;
    _currentQuestionIndex = cIndex.obs ;
    LoggingUtils.writeLog("_currentQuestionIndex has been incremented to $_currentQuestionIndex.value !");
  }
}
