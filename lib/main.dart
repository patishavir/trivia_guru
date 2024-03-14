import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import '../config/game_config.dart';
import './utils/questions_utils.dart';
import '../views/question_form.dart';

void main() {
  runApp(
    const MaterialApp(
      home: RouteSplash(),
    ),
  );
}

class RouteSplash extends StatefulWidget {
  const RouteSplash({super.key});
  @override
  RouteSplashState createState() => RouteSplashState();
}

class RouteSplashState extends State<RouteSplash> {
  @override
  void initState() {
    super.initState();
    rootBundle.loadString(GameConfig.questionsFilePath).then(
      (String jsonString) {
        QuestionsUtils.jsonString = jsonString;
        QuestionsUtils.buildQuestionListFromJsonString();
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const QuestionFormApp()));
      },
    ); //running initialisation code; getting prefs etc.
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child:
            CircularProgressIndicator(), //show splash screen here instead of progress indicator
      ),
    );
  }
}
