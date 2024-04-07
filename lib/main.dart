import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:get/get.dart';
import './config/game_config.dart';
import './config/session_data.dart';
import './utils/questions_utils.dart';
import './views/home_page.dart';
import './views/confetti_page.dart';
import './l10n/languages.dart';

void main() {
  final routes = [
    GetPage(name: '/ConfettiPage', page: () => const ConfettiPage()),
    GetPage(name: '/HomePage', page: () => const HomePage()),
  ];
  runApp(
    GetMaterialApp(
      translations: Languages(),
      // locale: Get.deviceLocale,
      locale: GameConfig.hebrewIlLocale,
      // locale: GameConfig.englishUsLocale,
      // locale: const Locale ("en"),
      // fallbackLocale:  GameConfig.fallbackLocale,
      getPages: routes,
      debugShowCheckedModeBanner: false,
      title: "Trivia Guru",
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: GameConfig.fontFamily,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontSize: GameConfig.fontSize),
          labelLarge: TextStyle(fontSize: GameConfig.fontSize),
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
    rootBundle.loadString(GameConfig.questionsFilePath).then(
      (String jsonString) {
        QuestionsUtils.jsonString = jsonString;
        QuestionsUtils.buildQuestionListFromJsonString();
        // Navigator.of(context).push(
        //    MaterialPageRoute(builder: (context) => const QuestionFormApp()));
        Get.off(() => const HomePage());
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
