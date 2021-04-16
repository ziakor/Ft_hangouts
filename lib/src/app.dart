import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ft_hangout/localization/localizations_delegate.dart';
import 'ui/HomePage.dart';

class App extends StatelessWidget {
  final Locale _locale = Locale('en', '');
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        locale: _locale,
        supportedLocales: [
          const Locale('en', ''),
          const Locale('fr', ''),
        ],
        localizationsDelegates: [
          AppLocalizationsDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        localeResolutionCallback: (locale, supportedLocales) {
          for (var supportedLocale in supportedLocales) {
            if (supportedLocale?.languageCode == locale?.languageCode &&
                supportedLocale?.countryCode == locale?.countryCode)
              return supportedLocale;
          }
          return supportedLocales?.first;
        },
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        title: 'Flutter Demo',
        home: MyHomePage());
  }
}
