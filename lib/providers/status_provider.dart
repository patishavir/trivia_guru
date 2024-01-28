import 'package:flutter/material.dart';
import '../common/logging_utils.dart';

class StatusProvider extends ChangeNotifier {
  bool _isWaitingForAnAnswer = true;

  bool get isWaitingForAnAnswer => _isWaitingForAnAnswer;

  void setIsWaitingForResponse(bool isWaitingForAnAnswer) {
    _isWaitingForAnAnswer = isWaitingForAnAnswer;
    LoggingUtils.writeLog("isWaitingForAnAnswer is $_isWaitingForAnAnswer !");
    notifyListeners();
  }
}
