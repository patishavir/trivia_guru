import 'package:flutter/material.dart';
import '../config/game_config.dart';
import '../config/session_data.dart';
import '../model/locale.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'home_page.dart';

class QuestionFormApp extends StatelessWidget {
  const QuestionFormApp({super.key});
  static const String heTitle = "אלוף הטריוויה";
  static const String enTitle = "Trivia Guru";
  @override
  Widget build(BuildContext context) {
    SessionData.initSessionData();
    return ChangeNotifierProvider(
      create: (context) => LocaleModel(),
      child: Consumer<LocaleModel>(
        builder: (context, localeModel, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: localeModel.locale,
          title: localeModel.locale == LocaleModel.hebrewLocale ? heTitle : enTitle,
          theme: ThemeData(
            primarySwatch: Colors.blue,
            fontFamily: GameConfig.fontFamily,
            textTheme: const TextTheme(
              bodyLarge: TextStyle(fontSize: GameConfig.fontSize),
              labelLarge: TextStyle(fontSize: GameConfig.fontSize),
            ),
          ),
          // home:  MyHomePage(title: AppLocalizations.of(context)!.app_title),
          home:  const MyHomePage(),
        ),
      ),
    );
  }
}




