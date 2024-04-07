import 'package:get/get.dart';

class Languages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          "select_an_answer": "Select an answer",
          "app_title": "Trivia King",
          "score": "Score",
          "summary_line":
              "You have answered correctly @correctAnswers out of @questionsPerGame questions !",
          "next_question": "Next question",
          "new_game_or_quit": "New game or quit ?",
          "quit": "Quit !",
          "new_game" : "New game"
        },
        'he_IL': {
          "select_an_answer": "בחר תשובה",
          "app_title": "אלוף הטריוויה",
          "score": "תוצאה",
          "summary_line":
              "ענית נכון על correctAnswers@ מתוך questionsPerGame@ שאלות !",
          "next_question": "השאלה הבאה",
          "new_game_or_quit": "שחק שוב או שנעצור ?",
          "quit": "מספיק ודי",
          "new_game": "משחק חדש",
        },
      };
}
