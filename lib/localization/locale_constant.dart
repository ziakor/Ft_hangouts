import 'dart:ui';

import 'package:flutter/material.dart';

import '../src/app.dart';

const String prefSelectedLanguageCode = "en";

Future<Locale> setLocale(String languageCode) async {
  //set local to bdd user table
  return _locale(languageCode);
}

Future<Locale> getLocale() async {
  //get local from bdd user table or set to 'en'
  return _locale('e');
}

Locale _locale(String languageCode) {
  return languageCode != null && languageCode.isNotEmpty
      ? Locale(languageCode, '')
      : Locale('en', '');
}

void changeLanguage(BuildContext context, String selectedLanguageCode) async {
  // var _locale = await setLocale(selectedLanguageCode);
  // App.setLocale(context, _locale);
  // change locale to the app
}
