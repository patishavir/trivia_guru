import 'package:flutter/material.dart';
import 'package:trivia_guru/pages/multiple_choice_question_form.dart';
import 'package:easy_localization/easy_localization.dart';
import 'l10n/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
      supportedLocales: L10n.all,
      path: 'assets/l10n',
      fallbackLocale: L10n.all[0],
      child: const MultipleChoiceApp(),
    ),
  );
}
