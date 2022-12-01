import 'package:trivia_guru/config/game_config.dart';

import '../objects/question.dart';

class QuestionsUtil {
  static Question getQuestion(int questionIndex) {
    String question = 'How old are you?';
    int answer = 4;
    String answerText =
        'I was born in 1929 therefore I am Thirty seven now.\nGod bless !\nViva Espania';
    List<String> answers = [];
    for (int i = 0; i < GameConfig.answersCount; i++) {
      int currentValue = questionIndex + i;
      answers.add(currentValue.toString());
    }
    List<String> answerz = [
      'ten',
      'twenty',
      'lorem ipsum dolor sit amet, consectetur adipiscing elit. id molestie ex ex quis nunc. Curabitur eget tellus sodales, tristique erat ut, facilisis sapien.. et molestie ex ex quis nunc.',
      'thrity seven'
    ];
    int difficulty = 1;
    List<String> subjects = ['personal', 'history'];
    String enteredBy = 'Moshe';
    DateTime entryDAte = DateTime.now();

    int correctAnswers = 0;
    int wrongAnswers = 0;

    var q1 = Question(question, answer, answerText, answers, difficulty,
        subjects, enteredBy, entryDAte, correctAnswers, wrongAnswers);

    return q1;
  }
}
