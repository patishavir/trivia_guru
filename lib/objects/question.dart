import 'dart:core';

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

  factory Question.fromJson(Map<String, dynamic> json) {
    print(json['question']);
    print(json['qimage']);
    print(json['aimage']);
    print(json['correctanswerindex']);
    print(json['answertext']);
    print(json['answer1']);
    print(json['answer2']);
    print(json['answer3']);
    print(json['answer4']);
    print(json['difficultylevel']);
    print(json['subject']);
    print(json['category']);
    print(json['timestamp']);
    print(json['qid']);
    return Question(
        question: json['question'] as String,
        qimage: json['qimage'] as String,
        aimage: json['aimage'] as String,
        correctanswerindex: json['correctanswerindex'] as int,
        answertext: json['answertext'] as String,
        answer1: json['answer1'] as String,
        answer2: json['answer2'] as String,
        answer3: json['answer3'] as String,
        answer4: json['answer4'] as String,
        difficultylevel: json['difficultylevel'] as int,
        subject: json['subject'] as String,
        category: json['category'] as String,
        timestamp: json['timestamp'] as String,
        qid: json['qid'] as int);
  }
}
