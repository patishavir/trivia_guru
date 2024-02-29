import 'dart:core';
import "dart:convert";
import '../common/logging_utils.dart';

class Question {
  String question;
  String? qimage;
  String? aimage;
  int correctanswerindex = 0;
  String answertext;
  int difficultylevel;
  String subject;
  String category;
  String answer1;
  String answer2;
  String answer3;
  String answer4;
  String timestamp;
  int qid;

  Question(
      {required this.question,
      this.qimage ="none",
      this.aimage="none",
      required this.correctanswerindex,
      required this.answertext,
      required this.answer1,
      required this.answer2,
      required this.answer3,
      required this.answer4,
      required this.difficultylevel,
      required this.subject,
      required this.category,
      required this.timestamp,
      required this.qid});

  Map toJson() => {
        'question': question,
        'qimage': qimage,
        'aimage': aimage,
        'correctanswerindex': correctanswerindex,
        'answertext': answertext,
        'answer1': answer1,
        'answer2': answer2,
        'answer3': answer3,
        'answer4': answer4,
        'difficultylevel': difficultylevel,
        'subject': subject,
        'category': category,
        'timestamp': timestamp,
        'qid': qid
      };

  factory Question.fromJson(Map<String, dynamic> jsonMap) {
    LoggingUtils.writeLog(json.encode(jsonMap));
    return Question(
        question: jsonMap['question'] as String,
        qimage: jsonMap['qimage'] as String,
        aimage: jsonMap['aimage'] as String,
        correctanswerindex: jsonMap['correctanswerindex'] as int,
        answertext: jsonMap['answertext'] as String,
        answer1: jsonMap['answer1'] as String,
        answer2: jsonMap['answer2'] as String,
        answer3: jsonMap['answer3'] as String,
        answer4: jsonMap['answer4'] as String,
        difficultylevel: jsonMap['difficultylevel'] as int,
        subject: jsonMap['subject'] as String,
        category: jsonMap['category'] as String,
        timestamp: jsonMap['timestamp'] as String,
        qid: jsonMap['qid'] as int);
  }
  void printMap (Map<String, dynamic> jsonMap) {
    print(jsonMap['question']);
    print(jsonMap['qimage']);
    print(jsonMap['aimage']);
    print(jsonMap['correctanswerindex']);
    print(jsonMap['answertext']);
    print(jsonMap['answer1']);
    print(jsonMap['answer2']);
    print(jsonMap['answer3']);
    print(jsonMap['answer4']);
    print(jsonMap['difficultylevel']);
    print(jsonMap['subject']);
    print(jsonMap['category']);
    print(jsonMap['timestamp']);
    print(jsonMap['qid']);
  }
}
