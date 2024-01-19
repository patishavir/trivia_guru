import 'package:flutter/material.dart';
import 'package:trivia_guru/pages/home_page_widgets.dart';
import '../common/logging_utils.dart';
import '../config/game_config.dart';
import '../config/session_data.dart';
import '../objects/question.dart';
import '../pages/confetti_page.dart';
import '../utils/questions_utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  late Question question;
  bool isCorrectAnswer = false;

  void processAnswer(int i) {
    setState(
      () {
        SessionData.selectedAnswer = i + 1;
        SessionData.waitingForAnAnswer = false;
        isCorrectAnswer =
            question.correctanswerindex == SessionData.selectedAnswer;
        if (isCorrectAnswer) {
          SessionData.correctAnswers++;
        } else {
          SessionData.wrongAnswers++;
        }
        LoggingUtils.writeLog(
            'selected answer $SessionData.selectedAnswer is ');
        LoggingUtils.writeLog(isCorrectAnswer ? 'correct' : 'wrong');
      },
    );
  }

  void processNextButton() {
    if ((SessionData.questionIndex + 1) == GameConfig.questionsPerGame) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const ConfettiPage(),
        ),
      );
    } else {
      setState(
        () {
          SessionData.waitingForAnAnswer = true;
          SessionData.questionIndex++;
          SessionData.selectedAnswer = 0;
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    question = QuestionsUtils.getQuestion(SessionData.questionIndex);
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
    );
  }

  List<Widget> getWidgetList() {
    List<Widget> widgetList = [];

    if (question.qimage != null && question.qimage!.isNotEmpty) {
      widgetList.add(getQuestionImage(question));
    }
    widgetList.add(
      getQuestion(question),
    );
    // next question container
    widgetList.add(
      getSelectAnAnswerRow(question, context, this),
    );
    widgetList.addAll(getAnswers(question, this, isCorrectAnswer));

    // add divider
    widgetList.add(
      const Divider(
        color: Colors.red,
        height: 5.0,
        thickness: 2.0,
      ),
    );
    // add answer text
    if (!SessionData.waitingForAnAnswer) {
      widgetList.add(getAnswerText(question, context));
    }
    return widgetList;
  }
}
