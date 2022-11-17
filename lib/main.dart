import 'package:flutter/material.dart';

import '../common/logging_utils.dart';
import 'screens/multiple_choice_question.dart';

void main() {
  LoggingUtils.initLogging();
  LoggingUtils.writeLog('starting app !!!');
  runApp(const MultipleChoiceApp());
}
