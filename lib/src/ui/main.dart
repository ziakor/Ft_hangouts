import 'package:flutter/material.dart';
import 'package:ft_hangout/src/bloc/bloc_provider.dart';
import 'package:ft_hangout/src/bloc/language_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ft_hangout/localization/localizations_delegate.dart';
import 'package:ft_hangout/src/ui/main_screen.dart';

class Main extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  Locale _locale;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: BlocProvider.of<LanguageBloc>(context).localeStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.data == null) {
          BlocProvider.of<LanguageBloc>(context).initLanguage();
          return (Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.white,
            ),
          ));
        }
        _locale = snapshot.data;
        return Container(
          child: MaterialApp(
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
                scaffoldBackgroundColor: Colors.black,
                textTheme: TextTheme(bodyText1: TextStyle(color: Colors.white)),
              ),
              title: 'Flutter Demo',
              home: MainScreen()),
        );
      },
    );
  }
}
