import 'package:ft_hangout/localization/language/languages.dart';

class LanguageFr extends Languages {
  @override
  String get appName => "Coucou fr";
  String get settings => "Paramètres";
  String get settingsTheme => "Changer le thème";
  String get settingsHeaderColor => "Changer la couleur du header";
  String get settingsLanguage => "Changer de langue";
  String get cancel => "Annuler";
  List<String> get languageList => ["Anglais", "Français"];
  String get settingsLanguageTitle => "Langue";
}
