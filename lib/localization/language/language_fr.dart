import 'package:ft_hangout/localization/language/languages.dart';

class LanguageFr extends Languages {
  @override
  String get appName => "Coucou fr";
  String get settings => "Paramètres";
  String get settingsTheme => "Changer le thème";
  String get settingsHeaderColor => "Changer la couleur de l'entête";
  String get settingsLanguage => "Changer de langue";
  String get close => "Fermer";
  List<String> get languageList => ["Anglais", "Français"];
  String get settingsLanguageTitle => "Langue";
  String get settingsHeaderColorTitle => "couleur de l'entête";
  String get settingsThemeTitle => "Thème";
  String get themeLight => "Clair";
  String get themeDark => "Sombre";
  String get floatingNewContact => "Nouveau contact";
  String get editContact => "Éditer";
  String get deleteContact => "Supprimer";
}
