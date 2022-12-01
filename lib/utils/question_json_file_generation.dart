import 'dart:convert';
import 'dart:io';

import '../common/logging_utils.dart';
import '../objects/question.dart';
import 'questions_utils.dart';

main() async {
  Question q1 = QuestionsUtil.getQuestion(1);
  LoggingUtils.writeLog(q1.toString());
  LoggingUtils.writeLog(q1.toJson().toString());
  const JsonEncoder encoder = JsonEncoder.withIndent('  ');
  try {
    String jsonString = encoder.convert(q1);
    LoggingUtils.writeLog(jsonString);
    const filename = 'c:\\temp\\dartfile.txt';
    var file = await File(filename).writeAsString(jsonString);
    LoggingUtils.writeLog('${file.absolute} has been successfully written !');
  } catch (e) {
    LoggingUtils.writeLog(e.toString());
  }
}
