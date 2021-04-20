import 'package:flutter/material.dart';
import 'package:ft_hangout/localization/language/languages.dart';
import 'package:ft_hangout/localization/locale_constant.dart';
import 'package:ft_hangout/src/app.dart';
import 'package:ft_hangout/src/bloc/bloc_provider.dart';
import 'package:ft_hangout/src/bloc/language_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ft_hangout/localization/localizations_delegate.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Locale _locale;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  Future<Locale> init() async {
    _locale = await getLocale();
    return _locale;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: BlocProvider.of<LanguageBloc>(context).localeStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.data != null) _locale = snapshot.data;
        if (snapshot.data == null) {
          BlocProvider.of<LanguageBloc>(context).initLanguage();
          return (Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.white,
            ),
          ));
        }
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
              ),
              title: 'Flutter Demo',
              home: HomePage()),
        );
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // The [AppBar] title text should update its message
        // according to the system locale of the target platform.
        // Switching between English and Spanish locales should
        // cause this text to update.
        title: Text("Title Text"),
      ),
      body: Column(children: [
        TextButton(
            onPressed: () =>
                BlocProvider.of<LanguageBloc>(context).changeLanguage("en"),
            child: Text(Languages.of(context).appName))
      ]),
    );
  }
}
