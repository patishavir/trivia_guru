import 'package:blinking_text/blinking_text.dart';
import 'package:flutter/material.dart';

import '../common/logging_utils.dart';
import '../config/app_config.dart';
import '../objects/question.dart';
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
  bool waitingForAnAnswer = true;
  int questionIndex = 0;
  int selectedAnswer = 0;
  int correctAnswers = 0;
  int wrongAnswers = 0;

  late Question question;

  void processAnswer() {
    setState(() {
      waitingForAnAnswer = false;
      LoggingUtils.writeLog('selected answer: $selectedAnswer');
      if (question.answer == selectedAnswer) {
        LoggingUtils.writeLog('$selectedAnswer is the correct answer');
      } else {
        LoggingUtils.writeLog('$selectedAnswer is a wrong answer');
      }
    });
  }

  void processNextButton() {
    setState(
      () {
        waitingForAnAnswer = true;
        questionIndex++;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    question = QuestionsUtil.getQuestion(questionIndex);
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
    if (questionIndex >= AppConfig.questionsPerGame) {
      widgetList.add(
        Container(
          margin: const EdgeInsets.only(top: 100.0),
          padding: const EdgeInsets.all(30.0),
          color: Colors.pink,
          child: BlinkText(
              'You have answered correctly\n$correctAnswers out of ${AppConfig.questionsPerGame} questions ! ',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: AppConfig.fontSize),
              beginColor: Colors.yellowAccent,
              endColor: Colors.white,
              times: 20,
              duration: const Duration(milliseconds: 500)),
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
      bool correctAnswer = question.answer == selectedAnswer;
      for (int i = 0; i < AppConfig.answersCount; i++) {
        LoggingUtils.writeLog('iteration number: $i');
        Color? buttonColor = Colors.grey[400];
        if (selectedAnswer == i + 1) {
          if (correctAnswer) {
            buttonColor = Colors.green;
            correctAnswers++;
          } else {
            buttonColor = Colors.red;
            wrongAnswers++;
          }
        }
        answerButtonList.add(
          Container(
            margin: const EdgeInsets.all(10.0),
            child: TextButton(
              onPressed: waitingForAnAnswer
                  ? () {
                      selectedAnswer = i + 1;
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
      if (!waitingForAnAnswer) {
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
              correctAnswers.toString(),
              style: const TextStyle(
                  fontSize: AppConfig.fontSize,
                  backgroundColor: Colors.green,
                  color: Colors.white),
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              wrongAnswers.toString(),
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
                  onTap: waitingForAnAnswer
                      ? null
                      : () {
                          selectedAnswer = 0;
                          waitingForAnAnswer = true;
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