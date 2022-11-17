class Question {
  late String question;
  int answer = 0;
  late String answerText;
  late List<String> answers;
  late int difficulty;
  late List<String> subjects;
  late String enteredBy;
  late DateTime entryDAte;
  int correctAnswers = 0;
  int wrongAnswers = 0;

  Question(
      this.question,
      this.answer,
      this.answerText,
      this.answers,
      this.difficulty,
      this.subjects,
      this.enteredBy,
      this.entryDAte,
      this.correctAnswers,
      this.wrongAnswers);

  Map toJson() => {
        'question': question,
        'answer': answer.toString(),
        'answerText': answerText,
        'answers': answers,
        'difficulty': difficulty.toString(),
        'subjects': subjects,
        'enteredBy': enteredBy,
        'entryDAte': entryDAte.toString(),
        'correctAnswers': correctAnswers.toString(),
        'wrongAnswers': wrongAnswers.toString()
      };
}
