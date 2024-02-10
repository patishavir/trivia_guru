import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../objects/score.dart';
import '../providers/status_provider.dart';
import 'home_page.dart';
import '../common/logging_utils.dart';
import '../config/game_config.dart';
import '../config/session_data.dart';
import '../objects/question.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Widget getQuestionImage(Question question) {
  return Center(
    child: SizedBox(
      width: 200.0,
      height: 200.0,
      child: Image.asset('assets/images/${question.qimage}', fit: BoxFit.fill),
    ),
  );
}

Widget getQuestionWidget(Question question) {
  return Container(
    margin: const EdgeInsets.all(4.0),
    padding: const EdgeInsets.all(4.0),
    decoration: BoxDecoration(
      color: const Color.fromARGB(255, 0, 0, 255),
      border: Border.all(color: Colors.black, width: 1.0),
    ),
    child: Text(
      question.question,
      style:
          const TextStyle(fontSize: GameConfig.fontSize, color: Colors.white),
    ),
  );
}

Widget getSelectAnAnswerRow(
    Question question, BuildContext context, MyHomePage myHomePageState) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Provider.of<StatusProvider>(context, listen: false)
      .isWaitingForAnAnswer
          ? Text(
              AppLocalizations.of(context)!.select_an_answer,
              style: const TextStyle(
                fontSize: GameConfig.fontSize,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 0, 0, 255),
                backgroundColor: Colors.white,
              ),
            )
          : ElevatedButton(
              style: const ButtonStyle(
                backgroundColor:
                    MaterialStatePropertyAll<Color>(Colors.white),
              ),
              child: Text(
                '${AppLocalizations.of(context)!.next_question} >',
                style: const TextStyle(
                    fontSize: GameConfig.fontSize,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 0, 0, 255)),
              ),
              onPressed: () {
                myHomePageState.processNextQuestionButton();
              },
            ),
      const Spacer(),
      Text('${AppLocalizations.of(context)!.score}: ',
          style: Theme.of(context).textTheme.bodyLarge),
      Text(
       Score.correctAnswers.toString(),
        style: const TextStyle(
            fontSize: GameConfig.fontSize,
            backgroundColor: Colors.green,
            color: Colors.white),
      ),
      const SizedBox(
        width: 8,
      ),
      Text(
        Score.wrongAnswers.toString(),
        style: const TextStyle(
            fontSize: GameConfig.fontSize,
            backgroundColor: Colors.red,
            color: Colors.white),
      ),
      const Spacer(),
    ],
  );
}

List<Widget> getAnswerButtons(
    Question question, MyHomePage myHomePage, bool isCorrectAnswer, BuildContext context) {
  List<Widget> answerButtonList = [];
  answerButtonList.clear();
  List<String> answers = [
    question.answer1,
    question.answer2,
    question.answer3,
    question.answer4
  ];
  for (int i = 0; i < GameConfig.answersCount; i++) {
    LoggingUtils.writeLog('iteration number: $i');
    Color? buttonColor = Colors.grey[400];
    if (i == SessionData.selectedAnswer - 1) {
      buttonColor = isCorrectAnswer ? Colors.green : Colors.red;
    }
    answerButtonList.add(
      Container(
        margin: const EdgeInsets.all(10.0),
        child: TextButton(
          onPressed:  Provider.of<StatusProvider>(context, listen: false)
              .isWaitingForAnAnswer
              ? () {
            onPressed:  Provider.of<StatusProvider>(context, listen: false)
                .setIsWaitingForAnAnswer(false);
                  myHomePage.processAnswerButtonClick(i);
                }
              : null,
          style: TextButton.styleFrom(
              backgroundColor: buttonColor, shadowColor: buttonColor),
          child: Text(
            answers[i],
            style: const TextStyle(
                color: Colors.black, fontSize: GameConfig.fontSize),
          ),
        ),
      ),
    );
  }
  return answerButtonList;
}

Widget getAnswerText (Question question, BuildContext context) {
  return Container(
    margin: const EdgeInsets.all(10.0),
    child: Text(question.answertext,
        style: Theme
            .of(context)
            .textTheme
            .bodyLarge),
  );
}
Widget getDivider () {
  return const Divider(
    color: Colors.red,
    height: 5.0,
    thickness: 2.0,
  );
}
