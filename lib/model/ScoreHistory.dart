class ScoreHistory {
  int _correctAnswers = 0;
  int _wrongAnswers = 0;
  int _questions = 0;
  int _timeStamp = 0;
  // int _timeStamp = DateTime.now().millisecondsSinceEpoch;
  ScoreHistory(this._correctAnswers, this._wrongAnswers, this._questions,
      this._timeStamp);
}
