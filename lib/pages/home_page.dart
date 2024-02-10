import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trivia_guru/pages/home_page_widgets.dart';
import '../objects/score.dart';
import '../common/logging_utils.dart';
import '../config/game_config.dart';
import '../config/session_data.dart';
import '../objects/question.dart';
import '../pages/confetti_page.dart';
import '../providers/status_provider.dart';
import '../utils/questions_utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  late BuildContext context;
  late Question question ;
  bool isCorrectAnswer = false;

  @override
  Widget build(BuildContext context) {
    this.context = context;
    question = QuestionsUtils.getQuestion(context.read<StatusProvider>().currentQuestionIndex);
    return Consumer<StatusProvider>(
      builder: (context, statusProvider, _) => Container(
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
                child: Column(
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
    List<Widget> widgetList = [];

    if (question.qimage != null && question.qimage!.isNotEmpty) {
      widgetList.add(getQuestionImage(question));
    }
    widgetList.add(
      getQuestionWidget(question),
    );
    // next question container
    widgetList.add(
      getSelectAnAnswerRow(question, context, this),
    );
    widgetList
        .addAll(getAnswerButtons(question, this, isCorrectAnswer, context));

    // add divider
    widgetList.add(getDivider());
    // add answer text
    if (!Provider.of<StatusProvider>(context, listen: false)
        .isWaitingForAnAnswer) {
      widgetList.add(getAnswerText(question, context));
    }
    return widgetList;
  }

  void processAnswerButtonClick(int i) {
    SessionData.selectedAnswer = i + 1;
    question = QuestionsUtils.getQuestion(context.read<StatusProvider>().currentQuestionIndex);
    isCorrectAnswer = question.correctanswerindex == SessionData.selectedAnswer;
    if (isCorrectAnswer) {
      Score.incrementCorrectAnswers();
    } else {
      Score.incrementWrongAnswers();
    }
    LoggingUtils.writeLog(
        'selected answer ${SessionData.selectedAnswer} is $isCorrectAnswer');
    Provider.of<StatusProvider>(context, listen: false)
        .setIsWaitingForAnAnswer(false);
  }

  void processNextQuestionButton() {
    if ((context.watch<StatusProvider>().currentQuestionIndex + 1) == GameConfig.questionsPerGame) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const ConfettiPage(),
        ),
      );
    } else {
      Provider.of<StatusProvider>(context, listen: false)
          .incrementCurrentQuestionIndex();
    }
  }
}
