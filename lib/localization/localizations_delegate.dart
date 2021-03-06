import 'package:flutter/cupertino.dart';
import 'package:ft_hangout/localization/language/language_en.dart';
import 'package:ft_hangout/localization/language/language_fr.dart';
import 'package:ft_hangout/localization/language/languages.dart';

class AppLocalizationsDelegate extends LocalizationsDelegate<Languages> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'fr'].contains(locale.languageCode);

  @override
  Future<Languages> load(Locale locale) => _load(locale);

  static Future<Languages> _load(Locale locale) async {
    switch (locale.languageCode) {
      case 'en':
        return LanguageEn();
        break;
      case 'fr':
        return LanguageFr();
        break;
      default:
        return LanguageEn();
    }
  }

  @override
  bool shouldReload(LocalizationsDelegate<Languages> old) => false;
}
