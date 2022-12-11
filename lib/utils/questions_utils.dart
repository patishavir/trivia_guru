import 'package:trivia_guru/config/game_config.dart';

import '../objects/question.dart';

class QuestionsUtil {
  static Question getQuestion(int questionIndex) {
    String question = 'How old are you?';
    String questionImageUrl =
        'https://media-cldnry.s-nbcnews.com/image/upload/t_fit-1240w,f_auto,q_auto:best/rockcms/2022-12/221207-Ukraine-Volodymyr-Zelenskyy-press-conference-an-7298b3.jpg';
    questionImageUrl =
        'https://images.unsplash.com/photo-1547721064-da6cfb341d50?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80';
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

    var q1 = Question(
        question,
        questionImageUrl,
        answer,
        answerText,
        answers,
        difficulty,
        subjects,
        enteredBy,
        entryDAte,
        correctAnswers,
        wrongAnswers);

    return q1;
  }
}
