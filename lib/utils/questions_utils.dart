import '../objects/question.dart';

class QuestionsUtil {
  static Question getQuestion() {
    String question = 'How old are you?';
    int answer = 4;
    String answerText =
        'I was born in 1929 therefore I am Thirty seven now. God bless !';
    List<String> answers = [
      'ten',
      'twenty',
      'lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus id volutpat libero. Vestibulum sollicitudin, sem vel aliquam aliquam, quam nisl scelerisque purus, et molestie ex ex quis nunc. Curabitur eget tellus sodales, tristique erat ut, facilisis sapien..orem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus id volutpat libero. Vestibulum sollicitudin, sem vel aliquam aliquam, quam nisl scelerisque purus, et molestie ex ex quis nunc. Curabitur eget tellus sodales, tristique erat ut, facilisis sapien.. et molestie ex ex quis nunc. Curabitur eget tellus sodales, tristique erat ut, facilisis sapien..',
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
