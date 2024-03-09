import 'package:flutter/material.dart';
import '../model/score.dart';
import '../common/logging_utils.dart';
import '../config/game_config.dart';
import '../config/session_data.dart';
import '../model/question.dart';
import '../views/confetti_page.dart';
import '../providers/game_state_provider.dart';
import '../utils/questions_utils.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  late BuildContext context;
  late Question question;
  late GameStateProvider gameStateProvider;

  bool isCorrectAnswer = false;


  @override
  Widget build(BuildContext context) {
    LoggingUtils.writeLog("Start building MyHomePage ...");
    this.context = context;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GameStateProvider()),
      ],
      child: Consumer<GameStateProvider>(
        builder: (context, gameStateProvider, child) => Container(
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
      ),
    );
  }

  List<Widget> getWidgetList() {
    gameStateProvider = Provider.of<GameStateProvider>(context, listen: false);
    LoggingUtils.writeLog("Starting getWidgetList in home_page ... gameState: ${gameStateProvider.gameState}");
    List<Widget> widgetList = [];
    question = QuestionsUtils.getQuestion(SessionData.currentQuestionIndex);
    if (question.qimage != null && question.qimage!.isNotEmpty) {
      widgetList.add(getQuestionImage());
    }
    widgetList.add(
      getQuestionWidget(),
    );
    // next question container
    widgetList.add(
      getSelectAnAnswerRow(),
    );
    widgetList.addAll(
        getAnswerButtons());

    // add divider
    widgetList.add(getDivider());
    // add answer text
    if (gameStateProvider.gameState == GameStateEnum.displayAnswer) {
      widgetList.add(getAnswerTextWidget());
    }
    return widgetList;
  }
  void processAnswerButtonClick(int i) {
    LoggingUtils.writeLog("Starting processAnswerButtonClick in home_page ... Button: $i");
    SessionData.selectedAnswer = i + 1;
    question = QuestionsUtils.getQuestion(SessionData.currentQuestionIndex);
    isCorrectAnswer = (question.correctanswerindex == SessionData.selectedAnswer);
    if (isCorrectAnswer) {
      Score.incrementCorrectAnswers();
    } else {
      Score.incrementWrongAnswers();
    }
    LoggingUtils.writeLog(
        'selected answer ${SessionData.selectedAnswer} is $isCorrectAnswer');
    gameStateProvider.setGameState(GameStateEnum.displayQuestion);
  }

  void processNextQuestionButtonPress() {
    LoggingUtils.writeLog(
        "Starting processNextQuestionButtonPress in home_page ...");
    if ((SessionData.currentQuestionIndex + 1) ==
        GameConfig.questionsPerGame) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const ConfettiPage(),
        ),
      );
    } else {
      SessionData.incrementCurrentQuestionIndex();
      gameStateProvider.setGameState(GameStateEnum.displayQuestion);
      SessionData.selectedAnswer = 0;
      SessionData.incrementCurrentQuestionIndex;
    }
  }
  Widget getQuestionImage() {
    return Center(
      child: SizedBox(
        width: 200.0,
        height: 200.0,
        child: Image.asset('assets/images/${question.qimage}', fit: BoxFit.fill),
      ),
    );
  }

  Widget getQuestionWidget() {
    LoggingUtils.writeLog("Starting getQuestionWidget in home_page_widgets ...");
    return Container(
      margin: const EdgeInsets.all(4.0),
      padding: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 0, 0, 255),
        border: Border.all(color: Colors.black, width: 1.0),
      ),
      child: Text(
        question.question,
        style:
        const TextStyle(fontSize: GameConfig.fontSize, color: Colors.white),
      ),
    );
  }

  Widget getSelectAnAnswerRow() {
    LoggingUtils.writeLog(
        "Starting getSelectAnAnswerRow in home_page_widgets ...");
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        gameStateProvider.gameState == GameStateEnum.displayQuestion
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
          style: const ButtonStyle(
            backgroundColor: MaterialStatePropertyAll<Color>(Colors.white),
          ),
          child: Text(
            '${AppLocalizations.of(context)!.next_question} >',
            style: const TextStyle(
                fontSize: GameConfig.fontSize,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 0, 0, 255)),
          ),
          onPressed: () {
            processNextQuestionButtonPress();
          },
        ),
        const Spacer(),
        Text('${AppLocalizations.of(context)!.score}: ',
            style: Theme.of(context).textTheme.bodyLarge),
        Text(
          Score.correctAnswers.toString(),
          style: const TextStyle(
              fontSize: GameConfig.fontSize,
              backgroundColor: Colors.green,
              color: Colors.white),
        ),
        const SizedBox(
          width: 8,
        ),
        Text(
          Score.wrongAnswers.toString(),
          style: const TextStyle(
              fontSize: GameConfig.fontSize,
              backgroundColor: Colors.red,
              color: Colors.white),
        ),
        const Spacer(),
      ],
    );
  }

  List<Widget> getAnswerButtons() {
    LoggingUtils.writeLog("Starting getAnswerButtons in home_page_widgets ...");
    List<Widget> answerButtonList = [];
    answerButtonList.clear();
    List<String> answers = [
      question.answer1,
      question.answer2,
      question.answer3,
      question.answer4
    ];
    for (int i = 0; i < GameConfig.answersCount; i++) {
      LoggingUtils.writeLog('building answer button number: $i');
      Color? buttonColor = Colors.grey[400];
      if (i == SessionData.selectedAnswer - 1) {
        buttonColor = isCorrectAnswer ? Colors.green : Colors.red;
      }
      answerButtonList.add(
        Container(
          margin: const EdgeInsets.all(10.0),
          child: TextButton(
            onPressed: (gameStateProvider.gameState == GameStateEnum.displayQuestion)
                ? () {
              LoggingUtils.writeLog("inside answerButton onPressed");
              processAnswerButtonClick(i);
              gameStateProvider.setGameState(GameStateEnum.displayAnswer);
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
    }
    return answerButtonList;
  }

  Widget getAnswerTextWidget() {
    LoggingUtils.writeLog(
        "Starting getAnswerTextWidget in home_page_widgets ...");
    return Container(
      margin: const EdgeInsets.all(10.0),
      child:
      Text(question.answertext, style: Theme.of(context).textTheme.bodyLarge),
    );
  }

  Widget getDivider() {
    LoggingUtils.writeLog("Starting getDivider ...");
    return const Divider(
      color: Colors.red,
      height: 5.0,
      thickness: 2.0,
    );
  }
}
