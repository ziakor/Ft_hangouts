import 'package:flutter/material.dart';
import 'package:ft_hangout/src/bloc/bloc_provider.dart';
import 'package:ft_hangout/src/bloc/header_color_bloc.dart';
import 'package:ft_hangout/src/bloc/language_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ft_hangout/localization/localizations_delegate.dart';
import 'package:ft_hangout/src/bloc/theme_bloc.dart';
import 'package:ft_hangout/src/ui/main_screen.dart';

class Main extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  Locale _locale;
  Color _headerColor;
  bool _isDarkTeme = false;
  ThemeData _buildThemes(bool darkTheme, Color _headerColor) {
    return darkTheme
        ? ThemeData.dark().copyWith(primaryColor: _headerColor)
        : ThemeData.light().copyWith(primaryColor: _headerColor);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: BlocProvider.of<HeaderColorBloc>(context).headerColorStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.data == null && _headerColor == null) {
          BlocProvider.of<HeaderColorBloc>(context).initHeaderColor();
          return (Center(
            child: CircularProgressIndicator(),
          ));
        }
        _headerColor = snapshot.data;
        return Container(
          child: StreamBuilder(
            stream: BlocProvider.of<LanguageBloc>(context).localeStream,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == null && _locale == null) {
                BlocProvider.of<LanguageBloc>(context).initLanguage();
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              _locale = snapshot.data;
              return StreamBuilder(
                  stream: BlocProvider.of<ThemeBloc>(context).themeStream,
                  builder: (context, snapshot) {
                    if (snapshot.data == null) {
                      BlocProvider.of<ThemeBloc>(context).initTheme();
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    _isDarkTeme = snapshot.data;
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
                            if (supportedLocale?.languageCode ==
                                    locale?.languageCode &&
                                supportedLocale?.countryCode ==
                                    locale?.countryCode) return supportedLocale;
                          }
                          return supportedLocales?.first;
                        },
                        theme: _buildThemes(_isDarkTeme, _headerColor),
                        debugShowCheckedModeBanner: false,
                        title: 'Flutter Demo',
                        home: MainScreen(),
                      ),
                    );
                  });
            },
          ),
        );
      },
    );
  }
}
