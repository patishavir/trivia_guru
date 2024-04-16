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
          "new_game" : "New game",
          "game_over": "The game is over !",
          "out_of_questions": "We have run out of questions\nThe game is over !",
          "grade_your_answer": "Grade your answer: (correct or wrong)",
          "show_answer": "Show answer",
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
          "game_over": "המשחק נגמר !",
          "out_of_questions": "נגמרו לנו השאלות\nהמשחק נגמר !",
          "grade_your_answer": "סמן את תשובתך: נכונה או שגויה",
          "show_answer": "הצג תשובה"
        },
      };
}
