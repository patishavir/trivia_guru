import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:trivia_guru/config/game_config.dart';
import '../model/question.dart';
import '../common/logging_utils.dart';

class QuestionsUtils {
  static List<Question> _questionsList = [];

  static void buildQuestionListFromJsonString() async {
    /*
    const String jsonString1= """
    [
  {
    "question":"איזו קבוצה זכתה הכי הרבה פעמים בגביע המדינה בכדורגל",
    "qimage":"zehavi.jpg",
    "correctanswerindex":3,
    "answertext":"מכבי תל אביב זכתה בגביע המדינה בכדור רגל 18 פעמים. יותר מכל קבוצה אחרת",
    "answer1":"הפועל תל אביב",
    "answer2":"מכבי חיפה",
    "answer3":"מכבי תל אביב",
    "answer4":"ביתר ירושלים",
    "difficultylevel":5,
    "subject":"israeli-soccer",
    "language":"HE",
    "timestamp":"2023-11-20 20:44:001+0200",
    "category":"sport",
    "qid":5858509,
    "aimage":"null"
  },
  {
    "question":"מתי נוסדה בישראל הליגה לכדורגל",
    "qimage":"",
    "correctanswerindex":2,
    "answertext":"הליגה לכדורגל נוסדה בתקופת המנדט הבריטי בשנת 1931",
    "answer1":"בסוף שנות העשרים של המאה העשרים",
    "answer2":"בתחילת שנות השלושים",
    "answer3":"בסוף שנות השלושים",
    "answer4":"בתחילת שנות הארבעים",
    "difficultylevel":5,
    "subject":"israeli-soccer",
    "language":"HE",
    "timestamp":"2023-10-28 20:55:038+0300",
    "category":"sport",
    "qid":15755966,
    "aimage":""
  },
  {
    "question":"היכן משחק עומר אצילי בעונה 2023-24",
    "qimage":"",
    "correctanswerindex":3,
    "answertext":"עומר אצילי משחק בעונה 2023-24 באל עין מליגת העל באיחוד האמירויות",
    "answer1":"קפריסין",
    "answer2":"ספרד",
    "answer3":"פורטוגל",
    "answer4":"איחוד האמירויות",
    "difficultylevel":5,
    "subject":"israeli-soccer",
    "language":"HE",
    "timestamp":"2023-11-20 20:52:043+0200",
    "category":"sport",
    "qid":6380938,
    "aimage":""
  }
]
""";
*/

    String jsonString1 =
        await rootBundle.loadString(GameConfig.questionsFilePath);
    List<dynamic> dynamicList = jsonDecode(jsonString1);
    LoggingUtils.writeLog(
        "dynamic list create by jsonDecode:\n  ${dynamicList.toString()}");
    _questionsList =
        List<Question>.from(dynamicList.map((x) => Question.fromJson(x)));
    LoggingUtils.writeLog("questionsFromJson has completed ...");
    LoggingUtils.writeLog(
        "questionsList  has ${_questionsList.length} entries...");
    LoggingUtils.writeLog("questionsFromJson: printing  questions  ...");
    for (Question question in _questionsList) {
      LoggingUtils.writeLog(question.question);
    }
  }

  static Question getQuestion(int questionIndex) {
    if (_questionsList.isEmpty) {
      buildQuestionListFromJsonString();
    }
    LoggingUtils.writeLog(
        "return question number $questionIndex:\n${_questionsList.elementAt(questionIndex)}");
    return _questionsList.elementAt(questionIndex);
  }
}
