import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/score.dart';
import '../controllers/state_controller.dart';
import 'home_page.dart';
import '../common/logging_utils.dart';
import '../config/game_config.dart';
import '../config/session_data.dart';
import '../model/question.dart';
import '../common/logging_utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../controllers/state_controller.dart';
import 'package:get/get.dart';

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
  LoggingUtils.writeLog("Starting getQuestionWidget in home_page_widgets ...");
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

Widget getSelectAnAnswerRow(Question question, BuildContext context,
    MyHomePage myHomePage, StateController controller) {
  LoggingUtils.writeLog(
      "Starting getSelectAnAnswerRow in home_page_widgets ...");
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      controller.gameStatee == GameState.displayAnswer
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
                backgroundColor: MaterialStatePropertyAll<Color>(Colors.white),
              ),
              child: Text(
                '${AppLocalizations.of(context)!.next_question} >',
                style: const TextStyle(
                    fontSize: GameConfig.fontSize,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 0, 0, 255)),
              ),
              onPressed: () {
                myHomePage.processNextQuestionButtonPress();
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

List<Widget> getAnswerButtons(Question question, MyHomePage myHomePage,
    bool isCorrectAnswer, StateController stateController) {
  LoggingUtils.writeLog("Starting getAnswerButtons in home_page_widgets ...");
  List<Widget> answerButtonList = [];
  answerButtonList.clear();
  List<String> answers = [
    question.answer1,
    question.answer2,
    question.answer3,
    question.answer4
  ];
  for (int i = 0; i < GameConfig.answersCount; i++) {
    LoggingUtils.writeLog('building answer button number: $i');
    Color? buttonColor = Colors.grey[400];
    if (i == SessionData.selectedAnswer - 1) {
      buttonColor = isCorrectAnswer ? Colors.green : Colors.red;
    }
    answerButtonList.add(
      Container(
        margin: const EdgeInsets.all(10.0),
        child: TextButton(
          onPressed: stateController.gameStatee == GameState.displayQuestion
              ? () {
                  onPressed:
                  myHomePage.processAnswerButtonClick(i);
                  stateController.gameState = GameState.displayAnswer.obs;
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

Widget getAnswerTextWidget(Question question, BuildContext context) {
  LoggingUtils.writeLog(
      "Starting getAnswerTextWidget in home_page_widgets ...");
  return Container(
    margin: const EdgeInsets.all(10.0),
    child:
        Text(question.answertext, style: Theme.of(context).textTheme.bodyLarge),
  );
}

Widget getDivider() {
  LoggingUtils.writeLog("Starting getDivider ...");
  return const Divider(
    color: Colors.red,
    height: 5.0,
    thickness: 2.0,
  );
}
