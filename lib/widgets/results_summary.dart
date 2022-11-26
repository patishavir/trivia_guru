import 'package:blinking_text/blinking_text.dart';
import 'package:flutter/material.dart';

import '../config/app_config.dart';
import '../config/game_data.dart';

class ResultsSummary {
  Container container = Container(
    margin: const EdgeInsets.only(top: 100.0),
    padding: const EdgeInsets.all(30.0),
    color: Colors.pink,
    child: BlinkText(
      'You have answered correctly\n$GameData.correctAnswers out of ${AppConfig.questionsPerGame} questions ! ',
      textAlign: TextAlign.center,
      style: const TextStyle(fontSize: AppConfig.fontSize),
      beginColor: Colors.yellowAccent,
      endColor: Colors.white,
      times: 200,
      duration: const Duration(milliseconds: 500),
    ),
  );
}
