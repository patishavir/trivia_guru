import 'package:flutter/material.dart';
import '../common/logging_utils.dart';

class StatusProvider extends ChangeNotifier {
  bool _isWaitingForAnAnswer = true;
  int _currentQuestionIndex = 0;

  bool get isWaitingForAnAnswer => _isWaitingForAnAnswer;
  int get currentQuestionIndex => _currentQuestionIndex;

  void setIsWaitingForAnAnswer(bool isWaitingForAnAnswer) {
    _isWaitingForAnAnswer = isWaitingForAnAnswer;
    LoggingUtils.writeLog("isWaitingForAnAnswer is $_isWaitingForAnAnswer !");
    notifyListeners();
  }
  void incrementCurrentQuestionIndex () {
    _currentQuestionIndex++;
    notifyListeners();
    LoggingUtils.writeLog("_currentQuestionIndex has been incremented to $_isWaitingForAnAnswer !");
  }
}
