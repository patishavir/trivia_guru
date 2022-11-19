import 'package:flutter/material.dart';

import '../common/logging_utils.dart';
import '../config/Config.dart';
import '../objects/question.dart';
import '../objects/questions_utils.dart';

class MultipleChoiceApp extends StatelessWidget {
  const MultipleChoiceApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trivia Guru',
      theme: ThemeData(
        primarySwatch: Colors.blue,
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
  int selection = 0;
  List<TextButton> answerButtonList = [];
  Question question = QuestionsUtil.getQuestion();

  void processAnswer() {
    setState(() {
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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: getWidgetList(),
        ),
      ),
    );
  }

  List<Widget> getWidgetList() {
    List<Widget> widgetList = [];

    widgetList.add(Container(
      margin: const EdgeInsets.all(3.0),
      padding: const EdgeInsets.all(3.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 5.0),
      ),
      child: Text(question.question),
    ));
    widgetList.add(Container(
      width: double.infinity,
      margin: const EdgeInsets.all(3.0),
      padding: const EdgeInsets.all(3.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 5.0),
      ),
      child: const Text("Select an answer:"),
    ));
    answerButtonList.clear();
    for (int i = 0; i < Config.answersCount; i++) {
      LoggingUtils.writeLog('iteration number: $i');
      answerButtonList.add(
        TextButton(
          onPressed: () {
            selection = i + 1;
            processAnswer();
          },
          style: TextButton.styleFrom(
              backgroundColor:
                  (question.answer == selection && selection == i + 1)
                      ? Colors.green
                      : Colors.red),
          child: Text(question.answers[i]),
        ),
      );
      widgetList.add(answerButtonList[i]);
    }
    widgetList.add(
      Container(
          margin: const EdgeInsets.all(3.0),
          padding: const EdgeInsets.all(3.0),
          decoration:
              BoxDecoration(border: Border.all(color: Colors.grey, width: 5.0)),
          child: Text("Select answer $selection")),
    );
    return widgetList;
  }
}
