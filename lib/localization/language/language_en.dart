import 'package:ft_hangout/localization/language/languages.dart';

class LanguageEn extends Languages {
  @override
  String get appName => "Coucou en";
  String get settings => "Settings";
  String get settingsTheme => "Change theme";
  String get settingsHeaderColor => "Change header color";
  String get settingsLanguage => "Change language";
  String get close => "Close";
  List<String> get languageList => ["English", "French"];
  String get settingsLanguageTitle => "Language";
  String get settingsHeaderColorTitle => "Header's color";
  String get settingsThemeTitle => "Theme";
  String get themeLight => "Light";
  String get themeDark => "Dark";
  String get floatingNewContact => "New contact";
  String get editContact => "Edit";
  String get deleteContact => "Delet";
}
