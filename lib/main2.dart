import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:trivia_guru/utils/future_builder.dart';
import '../config/game_config.dart';
import './utils/questions_utils.dart';
import '../views/question_form.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
     MaterialApp(
      home: runFutureBuilder(),
    ),
  );
}