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
  String get delete => "Supprimer";
  String get newContactTitle => "Nouveau contact";
  String get labelFirstName => "Prénom";
  String get labelLastName => "Nom";
  String get labelPhoneNumber => "Numéro de téléphone";
  String get labelEmail => "Adresse mail";
  String get labelBirthday => "Anniversaire";
  String get labelNotes => "Notes";
  String get invalidPhoneNumber => "Veuillez entrer le numéro de téléphone";
  String get invalidFirstName => "Veuillez entrer le prénom";
  String get contactDeletedMessage => "Contact supprimé";
}
