import 'package:get/get.dart';
import '../common/logging_utils.dart';

class StatusController extends GetxController {
  final  _isWaitingForAnAnswer = true.obs;
  bool get isWaitingForAnAnswer => _isWaitingForAnAnswer.value;

  void setIsWaitingForAnAnswer(bool isWaitingForAnAnswer) {
    _isWaitingForAnAnswer.value = isWaitingForAnAnswer;
    LoggingUtils.writeLog("isWaitingForAnAnswer is $_isWaitingForAnAnswer.value !");
    update();
    LoggingUtils.writeLog("isWaitingForAnAnswer is: update has been called !");
  }
}
