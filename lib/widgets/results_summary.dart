import 'package:blinking_text/blinking_text.dart';
import 'package:flutter/material.dart';

import '../config/game_config.dart';
import '../config/session_data.dart';

class ResultsSummary {
  Container container = Container(
    margin: const EdgeInsets.only(top: 100.0),
    padding: const EdgeInsets.all(30.0),
    color: Colors.pink,
    child: BlinkText(
      'You have answered correctly\n$SessionData.correctAnswers out of ${GameConfig.questionsPerGame} questions ! ',
      textAlign: TextAlign.center,
      style: const TextStyle(fontSize: GameConfig.fontSize),
      beginColor: Colors.yellowAccent,
      endColor: Colors.white,
      times: 200,
      duration: const Duration(milliseconds: 500),
    ),
  );
}
