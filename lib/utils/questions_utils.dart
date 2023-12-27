import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart' as p;
import 'package:trivia_guru/objects/question.dart';
import 'package:trivia_guru/common/logging_utils.dart';

class QuestionsUtils {
  static String jsonString = "";

  static Question getQuestion(int index) {
    List<Question> questionsList = getQuestionList();
    return questionsList.elementAt(0);
  }

  static getQuestionList() {
    readJsonFileFromAssets();
    LoggingUtils.writeLog(jsonString);
    List<Question> questionsList = questionsFromJson();
    LoggingUtils.writeLog(questionsList.toString());
    for (Question question in questionsList) {
      LoggingUtils.writeLog(question.question);
    }
  }

  static List<Question> questionsFromJson() {
    final List<dynamic> dynamicList = jsonDecode(jsonString);
    LoggingUtils.writeLog(dynamicList.toString());
    List<Question> questionsList =
        List<Question>.from(dynamicList.map((x) => Question.fromJson(x)));
    return questionsList;
  }

  static Future<String?>? readJsonFileFromAssets() async {
    Future<String> futString =
        rootBundle.loadString('assets/questions/q2.json');
    jsonString = await futString;
    LoggingUtils.writeLog(jsonString);
  }
}
