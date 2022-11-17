import 'dart:convert';
import 'dart:io';

import '../common/logging_utils.dart';
import '../objects/question.dart';
import '../objects/questions_utils.dart';

main() async {
  LoggingUtils.initLogging();
  Question q1 = QuestionsUtil.getQuestion();
  LoggingUtils.writeLog(q1.toString());
  LoggingUtils.writeLog(q1.toJson().toString());
  const JsonEncoder encoder = JsonEncoder.withIndent('  ');
  try {
    String str = encoder.convert(q1);
    LoggingUtils.writeLog(str);
    const filename = 'c:\\temp\\dartfile.txt';
    var file = await File(filename).writeAsString(str);
    LoggingUtils.writeLog('${file.absolute} has been successfully written !');
  } catch (e) {
    LoggingUtils.writeLog(e.toString());
  }
}
