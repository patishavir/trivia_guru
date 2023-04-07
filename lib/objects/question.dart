class Question {
  late String question;
  late String? imageUrl;
  int correctAnswerIndex = 0;
  late String answerText;
  late List<String> answers;
  late int difficultyLevel;
  late List<String> subjects;
  late String enteredBy;
  late DateTime entryDAte;
  int correctAnswers = 0;
  int wrongAnswers = 0;

  Question(
      this.question,
      this.imageUrl,
      this.correctAnswerIndex,
      this.answerText,
      this.answers,
      this.difficultyLevel,
      this.subjects,
      this.enteredBy,
      this.entryDAte,
      this.correctAnswers,
      this.wrongAnswers);

  Map toJson() => {
        'question': question,
        'questionImageUrl': imageUrl,
        'correctAnswer': correctAnswerIndex.toString(),
        'answerText': answerText,
        'answers': answers,
        'difficulty': difficultyLevel.toString(),
        'subjects': subjects,
        'enteredBy': enteredBy,
        'entryDAte': entryDAte.toString(),
        'correctAnswers': correctAnswers.toString(),
        'wrongAnswers': wrongAnswers.toString()
      };
}
