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
  static get questionsList => _questionsList;

  static Question getQuestion(int questionIndex) {
    LoggingUtils.writeLog(
        "getQuestion: return question number $questionIndex:  ${_questionsList.elementAt(questionIndex).question}");
    return _questionsList.elementAt(questionIndex);
  }
}