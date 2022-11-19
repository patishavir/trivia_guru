import 'dart:ui';

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
  bool disableAnswerButtons = false;
  int selection = 0;
  List<Widget> answerButtonList = [];
  Question question = QuestionsUtil.getQuestion();

  void processAnswer() {
    setState(() {
      disableAnswerButtons = true;
      LoggingUtils.writeLog('selection: $selection');
      if (question.answer == selection) {
        LoggingUtils.writeLog('$selection is the correct answer');
      } else {
        LoggingUtils.writeLog('$selection is a wrong answer');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
    for (int i = 0; i < AppConfig.answersCount; i++) {
      LoggingUtils.writeLog('iteration number: $i');
      Color? buttonColor = Colors.grey[400];
      if (selection == i + 1) {
        buttonColor =
            (question.answer == selection) ? Colors.green : Colors.red;
      }
      answerButtonList.add(
        Container(
          margin: const EdgeInsets.all(10.0),
          child: TextButton(
            onPressed: disableAnswerButtons
                ? null
                : () {
                    selection = i + 1;
                    processAnswer();
                  },
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
    Divider divider = const Divider(
      color: Colors.red,
      height: 30.0,
      thickness: 2.0,
    );
    widgetList.add(divider);
    Container answerContainer = Container(
      margin: const EdgeInsets.all(10.0),
      child: Text(question.answerText,
          style: Theme.of(context).textTheme.bodyText1),
    );
    widgetList.add(answerContainer);
    return widgetList;
  }
}
