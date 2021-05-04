import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ft_hangout/main.dart';
import 'package:ft_hangout/src/bloc/app_lifecycle.dart';
import 'package:ft_hangout/src/bloc/bloc_provider.dart';
import 'package:ft_hangout/src/bloc/header_color_bloc.dart';
import 'package:ft_hangout/src/bloc/language_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ft_hangout/localization/localizations_delegate.dart';
import 'package:ft_hangout/src/bloc/theme_bloc.dart';
import 'package:ft_hangout/src/ui/main_screen.dart';
import 'package:telephony/telephony.dart';

class Main extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

onBackgroundMessage(SmsMessage message) {
  debugPrint("onBackgroundMessage called");
}

class _MainState extends State<Main> with WidgetsBindingObserver {
  Locale _locale;
  Color _headerColor;
  bool _isDarkTeme = false;
  String _message = "";
  bool permissionsGranted;
  final Telephony telephony = Telephony.instance;
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    initPlatformState();
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  onMessage(SmsMessage message) async {
    print(message.body);
    setState(() {
      _message = message.body ?? "Error reading message body.";
    });
  }

  onSendStatus(SendStatus status) {
    setState(() {
      _message = status == SendStatus.SENT ? "sent" : "delivered";
    });
  }

  Future<void> initPlatformState() async {
    // Platform messages may fail, so we use a try/catch PlatformException.
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.

    final bool result = await telephony.requestPhoneAndSmsPermissions;

    if (result != null && result) {
      telephony.listenIncomingSms(
          onNewMessage: onMessage, onBackgroundMessage: onBackgroundMessage);
    }

    if (!mounted) return;
  }

  void perm() async {
    permissionsGranted = await telephony.requestPhoneAndSmsPermissions;
    ;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    BlocProvider.of<AppLifecycleBloc>(context).handleAppLifecycleState(state);
    super.didChangeAppLifecycleState(state);
  }

  ThemeData _buildThemes(bool darkTheme, Color _headerColor) {
    return darkTheme
        ? ThemeData.dark().copyWith(
            primaryColor: _headerColor,
            floatingActionButtonTheme: FloatingActionButtonThemeData(
              foregroundColor: _headerColor,
            ),
            textTheme: TextTheme(
                bodyText1: TextStyle(color: Colors.white, fontSize: 20),
                subtitle1:
                    TextStyle(color: Colors.grey.shade200, fontSize: 14)),
          )
        : ThemeData.light().copyWith(
            primaryColor: _headerColor,
            floatingActionButtonTheme: FloatingActionButtonThemeData(
              foregroundColor: _headerColor,
            ),
            textTheme: TextTheme(
                bodyText1: TextStyle(color: Colors.black, fontSize: 20),
                subtitle1:
                    TextStyle(color: Colors.grey.shade800, fontSize: 14)),
          );
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
