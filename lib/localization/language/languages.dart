import 'package:flutter/cupertino.dart';

abstract class Languages {
  static Languages of(BuildContext context) {
    return (Localizations.of<Languages>(context, Languages));
  }

  String get appName;
  String get close;
  String get settings;
  String get settingsTheme;
  String get settingsHeaderColor;
  String get settingsLanguage;
  String get settingsLanguageTitle;
  List<String> get languageList;
  String get settingsHeaderColorTitle;
  String get settingsThemeTitle;
  String get themeLight;
  String get themeDark;
  String get floatingNewContact;
}
