import 'package:trivia_guru/config/game_config.dart';
import 'dart:convert';
import 'dart:io';
import '../objects/question.dart';
import '../common/logging_utils.dart';
import 'package:path_provider/path_provider.dart';

class QuestionsUtils {
  static Question getQuestion(int questionIndex) {
    String question = 'How old are you?';
    String aimage = "zzz.jpg";
    String qimage =
        'https://media-cldnry.s-nbcnews.com/image/upload/t_fit-1240w,f_auto,q_auto:best/rockcms/2022-12/221207-Ukraine-Volodymyr-Zelenskyy-press-conference-an-7298b3.jpg';
    qimage =
        'https://images.unsplash.com/photo-1547721064-da6cfb341d50?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80';
    int correctanswerindex = 4;
    String answertext =
        'I was born in 1929 therefore I am Thirty seven now.\nGod bless !\nViva Espania';
    List<String> answers = [];
    for (int i = 0; i < GameConfig.answersCount; i++) {
      int currentValue = questionIndex + i;
      answers.add(currentValue.toString());
    }
    List<String> answerz = [
      'ten',
      'twenty',
      'lorem ipsum dolor sit amet, consectetur adipiscing elit. id molestie ex ex quis nunc. Curabitur eget tellus sodales, tristique erat ut, facilisis sapien.. et molestie ex ex quis nunc. please add a few more words to see wether scroll bar is doing the job and no yellow and black stips show on the screen',
      'thrity seven'
    ];
    int difficultylevel = 1;
    String subject = 'israeli-soccer';
    String category = 'sport';

    int correctAnswers = 0;
    int wrongAnswers = 0;
    String timestamp = DateTime.now().toString();
    int qid = 123456789;
    var q1 = Question(
        question: question,
        qimage: qimage,
        aimage: aimage,
        correctanswerindex: correctanswerindex,
        answertext: answertext,
        answer1: answerz[0],
        answer2: answerz[1],
        answer3: answerz[2],
        answer4: answerz[3],
        difficultylevel: difficultylevel,
        subject: subject,
        category: category,
        timestamp: timestamp,
        qid: qid);
    writeJsonString(q1);
    return q1;
  }

  static void writeJsonString(Question q1) async {
    LoggingUtils.writeLog(q1.toString());
    LoggingUtils.writeLog(q1.toJson().toString());
    const JsonEncoder encoder = JsonEncoder.withIndent('  ');
    try {
      String jsonString = encoder.convert(q1);
      LoggingUtils.writeLog(jsonString);
      //  Directory appDocDir = await getApplicationDocumentsDirectory();
      Directory appDocDir = await getTemporaryDirectory();
      String appDocPath = appDocDir.path;
      String fullPath = '$appDocPath/question.json';
      LoggingUtils.writeLog(fullPath);
      var file = await File(fullPath).writeAsString(jsonString);
      LoggingUtils.writeLog('${file.absolute} has been successfully written !');
    } catch (e) {
      LoggingUtils.writeLog(e.toString());
    }
  }
}
