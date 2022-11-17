import 'question.dart';

class QuestionsUtil {
  static Question getQuestion() {
    String question = 'How old are you?';
    int answer = 4;
    String answerText = 'Thirty seven';
    List<String> answers = ['ten', 'twenty', 'thirty', 'thrity seven'];
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
