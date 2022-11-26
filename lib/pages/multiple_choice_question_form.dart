import 'package:flutter/material.dart';

import '../common/logging_utils.dart';
import '../config/app_config.dart';
import '../config/game_data.dart';
import '../objects/question.dart';
import '../pages/confetti_page.dart';
import '../utils/questions_utils.dart';

class MultipleChoiceApp extends StatelessWidget {
  const MultipleChoiceApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Trivia Guru',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'NovaSlim',
        textTheme: const TextTheme(
          bodyText1: TextStyle(fontSize: AppConfig.fontSize),
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

  void processAnswer() {
    setState(() {
      GameData.waitingForAnAnswer = false;
      LoggingUtils.writeLog('selected answer: $GameData.selectedAnswer');
      if (question.answer == GameData.selectedAnswer) {
        LoggingUtils.writeLog('$GameData.selectedAnswer is the correct answer');
      } else {
        LoggingUtils.writeLog('$GameData.selectedAnswer is a wrong answer');
      }
    });
  }

  void processNextButton() {
    setState(
      () {
        GameData.waitingForAnAnswer = true;
        GameData.questionIndex++;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    question = QuestionsUtil.getQuestion(GameData.questionIndex);
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
    Container bottomRowContainer;
    if (GameData.questionIndex >= AppConfig.questionsPerGame) {
      Navigator.of(context).push(
        MaterialPageRoute(
          // Builder for the NextPage
          // class's constructor.
          builder: (context) => const ConfettiPage(),
        ),
      );
    } else {
      widgetList.add(
        Container(
          margin: const EdgeInsets.all(10.0),
          padding: const EdgeInsets.all(3.0),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 0, 0, 255),
            border: Border.all(color: Colors.black, width: 1.0),
          ),
          child: Text(
            question.question,
            style: const TextStyle(
                fontSize: AppConfig.fontSize, color: Colors.white),
          ),
        ),
      );
      widgetList.add(
        Container(
          width: double.infinity,
          margin: const EdgeInsets.all(5.0),
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 1.0),
          ),
          child: const Text(
            "Select an answer:",
            style: TextStyle(
                fontSize: AppConfig.fontSize,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 0, 0, 255)),
          ),
        ),
      );
      answerButtonList.clear();
      bool correctAnswer = question.answer == GameData.selectedAnswer;
      for (int i = 0; i < AppConfig.answersCount; i++) {
        LoggingUtils.writeLog('iteration number: $i');
        Color? buttonColor = Colors.grey[400];
        if (GameData.selectedAnswer == i + 1) {
          if (correctAnswer) {
            buttonColor = Colors.green;
            GameData.correctAnswers++;
          } else {
            buttonColor = Colors.red;
            GameData.wrongAnswers++;
          }
        }
        answerButtonList.add(
          Container(
            margin: const EdgeInsets.all(10.0),
            child: TextButton(
              onPressed: GameData.waitingForAnAnswer
                  ? () {
                      GameData.selectedAnswer = i + 1;
                      processAnswer();
                    }
                  : null,
              style: TextButton.styleFrom(
                  backgroundColor: buttonColor, shadowColor: buttonColor),
              child: Text(
                question.answers[i],
                style: const TextStyle(
                    color: Colors.black, fontSize: AppConfig.fontSize),
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
      if (!GameData.waitingForAnAnswer) {
        widgetList.add(
          Container(
              margin: const EdgeInsets.all(10.0),
              child: Text(question.answerText,
                  style: Theme.of(context).textTheme.bodyText1)),
        );
      }

      Container bottomRowContainer = Container(
        margin: const EdgeInsets.all(10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text('Score: ', style: Theme.of(context).textTheme.bodyText1),
            Text(
              GameData.correctAnswers.toString(),
              style: const TextStyle(
                  fontSize: AppConfig.fontSize,
                  backgroundColor: Colors.green,
                  color: Colors.white),
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              GameData.wrongAnswers.toString(),
              style: const TextStyle(
                  fontSize: AppConfig.fontSize,
                  backgroundColor: Colors.red,
                  color: Colors.white),
            ),
            const Spacer(),
            Material(
              type: MaterialType.transparency,
              child: Ink(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 3.0),
                  color: Colors.blue.shade600,
                  shape: BoxShape.circle,
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(500.0),
                  onTap: GameData.waitingForAnAnswer
                      ? null
                      : () {
                          GameData.selectedAnswer = 0;
                          GameData.waitingForAnAnswer = true;
                          processNextButton();
                        },
                  child: const Padding(
                    padding: EdgeInsets.all(3.0),
                    child: Icon(
                      Icons.arrow_right,
                      size: 30.0,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      );
      widgetList.add(bottomRowContainer);
    }
    return widgetList;
  }
}
