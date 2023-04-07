import 'package:flutter/material.dart';

import '../common/logging_utils.dart';
import '../config/game_config.dart';
import '../config/session_data.dart';
import '../objects/question.dart';
import '../pages/confetti_page.dart';
import '../utils/questions_utils.dart';

class MultipleChoiceApp extends StatelessWidget {
  const MultipleChoiceApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SessionData.initSessionData();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Trivia Guru',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'NovaSlim',
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontSize: GameConfig.fontSize),
          labelLarge: TextStyle(fontSize: GameConfig.fontSize),
        ),
      ),
      home: const MyHomePage(title: 'Trivia Guru'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

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
        isCorrectAnswer = question.correctAnswerIndex == SessionData.selectedAnswer;
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
          title: Text(widget.title),
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

    if (question.imageUrl != null) {
      widgetList.add(
        SizedBox(
          width: double.infinity,
          height: 250.0,
          child: Image.network(
            question.imageUrl!,
            fit: BoxFit.contain,
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
            ? const Text(
                "Select an answer:",
                style: TextStyle(
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
                child: const Text(
                  "Next question >",
                  style: TextStyle(
                      fontSize: GameConfig.fontSize,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 0, 0, 255)),
                ),
                onPressed: () {
                  processNextButton();
                },
              ),
        const Spacer(),
        Text('Score: ', style: Theme.of(context).textTheme.bodyLarge),
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
    ));
    answerButtonList.clear();

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
              question.answers[i],
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
            child: Text(question.answerText,
                style: Theme.of(context).textTheme.bodyLarge)),
      );
    }

    return widgetList;
  }
}
