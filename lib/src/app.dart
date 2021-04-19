import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ft_hangout/localization/locale_constant.dart';
import 'package:ft_hangout/localization/localizations_delegate.dart';
import 'package:ft_hangout/src/helpers/DatabaseHelper.dart';
import 'ui/home_page.dart';

class App extends StatefulWidget {
  static void setLocale(BuildContext context, Locale newLocale) {
    var state = context.findAncestorStateOfType<_AppState>();
    state.setLocale(newLocale);
  }

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  Locale _locale = Locale('en', '');

  @override
  void initState() {
    super.initState();
    DatabaseHelper.instance.getContacts();
    getLocale();
  }

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

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
