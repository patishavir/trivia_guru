import 'dart:convert';
import '../model/question.dart';
import '../common/logging_utils.dart';

class QuestionsUtils {
  static List<Question> _questionsList = [];
  static String jsonString = "";

  static void buildQuestionListFromJsonString() {
    List<dynamic> dynamicList = jsonDecode(jsonString);
    LoggingUtils.writeLog(
        "dynamic list create by jsonDecode:\n  ${dynamicList.toString()}");
    _questionsList =
        List<Question>.from(dynamicList.map((x) => Question.fromJson(x)));
    LoggingUtils.writeLog(
        "buildQuestionListFromJsonString has completed successfully.\nquestionsList  has ${_questionsList.length} entries...");

    LoggingUtils.writeLog(
        "buildQuestionListFromJsonString: printing  questions  ...");
    for (Question question in _questionsList) {
      LoggingUtils.writeLog(question.question);
    }
  }

  static Question getQuestion(int questionIndex) {
    LoggingUtils.writeLog(
        "return question number $questionIndex:\n${_questionsList.elementAt(questionIndex)}");
    return _questionsList.elementAt(questionIndex);
  }
}