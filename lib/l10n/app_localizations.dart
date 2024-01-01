import 'dart:async' show Future;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:flutter_localizations/flutter_localizations.dart';

class AppLocalizations {
  static AppLocalizations? instance;
  Map<String, String>? _localizedStrings;

  static Future<AppLocalizations> load(Locale locale) async {
    final AppLocalizations instance = AppLocalizations();

    final String jsonString =
        await rootBundle.loadString('i18n/${locale.languageCode}/strings.json');

    final Map<String, dynamic> jsonMap = json.decode(jsonString);

    instance._localizedStrings = jsonMap.map((key, value) {
      return MapEntry(key, value.toString());
    });

    return instance;
  }

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  String translate(String key) {
    return _localizedStrings[key];
  }
}
