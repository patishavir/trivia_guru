import 'package:flutter/material.dart';
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
  State<MyHomePage> createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {
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
          title: Text( AppLocalizations.of(context)!.app_title,),
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
    List<Widget> answerButtonList = [];

    if (question.qimage != null && question.qimage!.isNotEmpty) {
      widgetList.add(
        Center(
          child: SizedBox(
            width: 200.0,
            height: 200.0,
            child: Image.asset('assets/images/${question.qimage}',
                fit: BoxFit.fill),
          ),
        ),
      );
    }
    widgetList.add(
      Container(
        margin: const EdgeInsets.all(4.0),
        padding: const EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 0, 0, 255),
          border: Border.all(color: Colors.black, width: 1.0),
        ),
        child: Text(
          question.question,
          style: const TextStyle(
              fontSize: GameConfig.fontSize, color: Colors.white),
        ),
      ),
    );
    // next question container
    widgetList.add(Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SessionData.waitingForAnAnswer
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
          style: ButtonStyle(
            backgroundColor:
            const MaterialStatePropertyAll<Color>(Colors.white),
            elevation: MaterialStateProperty.resolveWith<double>(
                  (Set<MaterialState> states) {
                if (states.contains(MaterialState.pressed)) {
                  return 10.0;
                } else {
                  return 10.0;
                }
              },
            ),
          ),
          child: Text(
            '${AppLocalizations.of(context)!.next_question} >',
            style: const TextStyle(
                fontSize: GameConfig.fontSize,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 0, 0, 255)),
          ),
          onPressed: () {
            processNextButton();
          },
        ),
        const Spacer(),
        Text('${AppLocalizations.of(context)!.score}: ', style: Theme.of(context).textTheme.bodyLarge),
        Text(
          SessionData.correctAnswers.toString(),
          style: const TextStyle(
              fontSize: GameConfig.fontSize,
              backgroundColor: Colors.green,
              color: Colors.white),
        ),
        const SizedBox(
          width: 8,
        ),
        Text(
          SessionData.wrongAnswers.toString(),
          style: const TextStyle(
              fontSize: GameConfig.fontSize,
              backgroundColor: Colors.red,
              color: Colors.white),
        ),
        const Spacer(),
      ],
    ),
    );
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
            onPressed: SessionData.waitingForAnAnswer
                ? () {
              processAnswer(i);
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
      widgetList.add(answerButtonList[i]);
    }

    // add divider
    widgetList.add(const Divider(
      color: Colors.red,
      height: 5.0,
      thickness: 2.0,
    ));
    // add answer text
    if (!SessionData.waitingForAnAnswer) {
      widgetList.add(
        Container(
            margin: const EdgeInsets.all(10.0),
            child: Text(question.answertext,
                style: Theme.of(context).textTheme.bodyLarge)),
      );
    }

    return widgetList;
  }
}