import 'package:flutter/material.dart';
import 'package:trivia_guru/views/home_page_widgets.dart';
import '../objects/score.dart';
import '../common/logging_utils.dart';
import '../config/game_config.dart';
import '../config/session_data.dart';
import '../objects/question.dart';
import '../views/confetti_page.dart';
import '../controllers/status_controller.dart';
import '../utils/questions_utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  late BuildContext context;
  late Question question;

  bool isCorrectAnswer = false;
  final StatusController statusController = Get.put(StatusController());

  @override
  Widget build(BuildContext context) {
    LoggingUtils.writeLog("Start building MyHomePage ...");
    this.context = context;
    question = QuestionsUtils.getQuestion(SessionData.currentQuestionIndex);
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.red, width: 1.0),
      ),
      constraints: const BoxConstraints(maxWidth: 400.0, maxHeight: 800.0),
      child: Scaffold(
        appBar: AppBar(
          // title: Text(widget.title),
          title: Text(
            AppLocalizations.of(context)!.app_title,
          ),
          centerTitle: true,
        ),
        body: Center(
          child: Align(
            alignment: Alignment.topLeft,
            child: SingleChildScrollView(
              child: Obx(
                () => Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: getWidgetList(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> getWidgetList() {
    LoggingUtils.writeLog("Starting getWidgetList in home_page ...");
    List<Widget> widgetList = [];

    if (question.qimage != null && question.qimage!.isNotEmpty) {
      widgetList.add(getQuestionImage(question));
    }
    widgetList.add(
      getQuestionWidget(question),
    );
    // next question container
    widgetList.add(
      getSelectAnAnswerRow(question, context, this, statusController),
    );
    widgetList
        .addAll(getAnswerButtons(question, this, isCorrectAnswer, statusController));

    // add divider
    widgetList.add(getDivider());
    // add answer text
    if (!statusController.isWaitingForAnAnswer) {
      widgetList.add(getAnswerTextWidget(question, context));
    }
    return widgetList;
  }

  void processAnswerButtonClick(int i) {
    LoggingUtils.writeLog("Starting processAnswerButtonClick in home_page ...");
    SessionData.selectedAnswer = i + 1;
    question = QuestionsUtils.getQuestion(SessionData.currentQuestionIndex);
    isCorrectAnswer = question.correctanswerindex == SessionData.selectedAnswer;
    if (isCorrectAnswer) {
      Score.incrementCorrectAnswers();
    } else {
      Score.incrementWrongAnswers();
    }
    LoggingUtils.writeLog(
        'selected answer ${SessionData.selectedAnswer} is $isCorrectAnswer');
    statusController.setIsWaitingForAnAnswer(false);
  }

  void processNextQuestionButtonPress() {
    LoggingUtils.writeLog("Starting processNextQuestionButtonPress in home_page ...");
    if ((SessionData.currentQuestionIndex + 1) == GameConfig.questionsPerGame) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const ConfettiPage(),
        ),
      );
    } else {
      SessionData.incrementCurrentQuestionIndex();
      SessionData.selectedAnswer = 0;
    }
  }
}
