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
  String get editContact;
  String get deleteContact;
  String get delete;
  String get newContactTitle;
  String get labelFirstName;
  String get labelLastName;
  String get labelPhoneNumber;
  String get labelEmail;
  String get labelBirthday;
  String get labelNotes;
  String get invalidPhoneNumber;
  String get invalidFirstName;
  String get contactDeletedMessage;
  String get labelAddress;
  String get at;
}
