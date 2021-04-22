import 'package:ft_hangout/localization/language/languages.dart';

class LanguageEn extends Languages {
  @override
  String get appName => "Coucou en";
  String get settings => "Settings";
  String get settingsTheme => "Change theme";
  String get settingsHeaderColor => "Change header color";
  String get settingsLanguage => "Change language";
  String get cancel => "Cancel";
  List<String> get languageList => ["English", "French"];
  String get settingsLanguageTitle => "Language";
}
