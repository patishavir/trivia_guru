import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../common/logging_utils.dart';
import '../config/game_config.dart';
import '../config/session_data.dart';
import '../providers/locale_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'home_page.dart';

class QuestionFormApp extends StatelessWidget {
  const QuestionFormApp({super.key});
  static const String heTitle = "אלוף הטריוויה";
  static const String enTitle = "Trivia Guru";
  @override
  Widget build(BuildContext context) {
    LoggingUtils.writeLog("Start building QuestionFormApp ...");
    SessionData.initSessionData();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LocaleProvider()),
      ],
      child: Consumer<LocaleProvider>(
        builder: (context, localeModel, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: localeModel.locale,
          title: localeModel.locale == LocaleProvider.hebrewLocale
              ? heTitle
              : enTitle,
          theme: ThemeData(
            primarySwatch: Colors.blue,
            fontFamily: GameConfig.fontFamily,
            textTheme: const TextTheme(
              bodyLarge: TextStyle(fontSize: GameConfig.fontSize),
              labelLarge: TextStyle(fontSize: GameConfig.fontSize),
            ),
          ),
          home: const MyHomePage(),
        ),
      ),
    );
  }
}
