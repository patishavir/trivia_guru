import 'dart:math';

import 'package:blinking_text/blinking_text.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trivia_guru/providers/score_provider.dart';

import '../config/game_config.dart';
import '../config/session_data.dart';
import '../common/logging_utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ConfettiPage extends StatefulWidget {
  const ConfettiPage({super.key});

  @override
  ConfettiPageState createState() => ConfettiPageState();
}

class ConfettiPageState extends State<ConfettiPage> {
  late ConfettiController confettiController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => confettiController.play());
    setState(() {
      initController();
      stopController();
    });
  }

  @override
  void dispose() {
    super.dispose();
    confettiController.dispose();
    debugPrint("dispose method has completed");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        //  title: const Text("Flutter Confetti Animation Demo"),
        automaticallyImplyLeading: true,
      ),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(top: 100.0),
              padding: const EdgeInsets.all(30.0),
              color: Colors.pink,
              child: BlinkText(
               // 'You have answered correctly\n${SessionData.correctAnswers} out of ${GameConfig.questionsPerGame} questions ! ',
                AppLocalizations.of(context)!.summary_line(Provider.of<ScoreProvider>(context, listen: false).correctAnswers, GameConfig.questionsPerGame),
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: GameConfig.fontSize),
                beginColor: Colors.yellowAccent,
                endColor: Colors.white,
                times: 200,
                duration: const Duration(milliseconds: 500),
              ),
            ),
            buildConfettiWidget(confettiController, pi / 1),
            buildConfettiWidget(confettiController, pi / 4),
          ],
        ),
      ),
    );
  }

  Align buildConfettiWidget(controller, double blastDirection) {
    return Align(
      alignment: Alignment.topCenter,
      child: ConfettiWidget(
        maximumSize: const Size(30, 30),
        shouldLoop: false,
        confettiController: controller,
        blastDirection: blastDirection,
        blastDirectionality: BlastDirectionality.directional,
        maxBlastForce: 20,
        // set a lower max blast force
        minBlastForce: 8,
        // set a lower min blast force
        emissionFrequency: 1,
        numberOfParticles: 8,
        // a lot of particles at once
        gravity: 1,
      ),
    );
  }

  void initController() {
    confettiController =
        ConfettiController(duration: const Duration(seconds: 60));
  }

  Future<void> stopController() {
    return Future.delayed(
        const Duration(seconds: GameConfig.confettiAnimationDuration), () {
      confettiController.stop();
      LoggingUtils.writeLog('controller has stopped');
      Navigator.of(context).pop();
    });
  }
}
