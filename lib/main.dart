import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:get/get.dart';
import 'package:trivia_guru/views/game_over.dart';

import './config/app_config.dart';
import './l10n/languages.dart';
import './utils/questions_utils.dart';
import './views/confetti_page.dart';
import './views/home_page.dart';

void main() {
  final routes = [
    GetPage(name: '/confettiPage', page: () => const ConfettiPage()),
    GetPage(name: '/homePage', page: () => HomePage()),
    GetPage(name: '/gameOver', page: () =>  GameOver(myText: 'game_over')),
    GetPage(name: '/outOfQuestions', page: () =>  GameOver(myText: 'out_of_questions')),
  ];
  runApp(
   GetMaterialApp(
      translations: Languages(),
      // locale: GameConfig.hebrewIlLocale,
      locale: AppConfig.currentLocale,
      getPages: routes,
      debugShowCheckedModeBanner: false,
      title: AppConfig.appTitle,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: AppConfig.currentLocale == AppConfig.hebrewIlLocale ? AppConfig.hebFontFamily : AppConfig.enFontFamily,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontSize: AppConfig.fontSize),
          labelLarge: TextStyle(fontSize: AppConfig.fontSize),
        ),
      ),
      home: const RouteSplash(),
    ),
  );
}

class RouteSplash extends StatefulWidget {
  const RouteSplash({super.key});
  @override
  RouteSplashState createState() => RouteSplashState();
}

class RouteSplashState extends State<RouteSplash> {
  @override
  void initState() {
    super.initState();
    rootBundle.loadString(AppConfig.questionsFilePath).then(
      (String jsonString) {
        QuestionsUtils.jsonString = jsonString;
        QuestionsUtils.buildQuestionListFromJsonString();
        Get.offAllNamed('/homePage');
      },
    ); //running initialisation code; getting prefs etc.
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child:
            CircularProgressIndicator(), //show splash screen here instead of progress indicator
      ),
    );
  }
}
