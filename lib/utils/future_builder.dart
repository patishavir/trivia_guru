import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import '../config/game_config.dart';
import '../common/logging_utils.dart';
import 'questions_utils.dart';

void runFutureBuilder() {
  FutureBuilder(
    builder: (ctx, snapshot) {
// Checking if future is resolved or not
      if (snapshot.connectionState == ConnectionState.done) {
// If we got an error
        if (snapshot.hasError) {
          return Center(
            child: Text(
              '${snapshot.error} occurred',
              style: const TextStyle(fontSize: 18),
            ),
          );
// if we got our data
        } else if (snapshot.hasData) {
// Extracting data from snapshot object
          final data = snapshot.data as String;
          QuestionsUtils.jsonString = data;
          QuestionsUtils.buildQuestionListFromJsonString();
          LoggingUtils.writeLog(QuestionsUtils.jsonString);
          return const Center(
            child: Text(
              "Questions have been successfully loaded",
              style: TextStyle(fontSize: 18),
            ),
          );
        }
      }
// Displaying LoadingSpinner to indicate waiting state
      return const Center(
        child: CircularProgressIndicator(),
      );
    },

// Future that needs to be resolved
// inorder to display something on the Canvas
    future: rootBundle.loadString(GameConfig.questionsFilePath),
  );
}
