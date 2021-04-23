import 'dart:async';

import 'package:ft_hangout/src/bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeBloc implements Bloc {
  bool _darkTheme = false;
  final _themeController = StreamController<bool>();
  bool get darktheme => _darkTheme;

  StreamSink<bool> get themeSink => _themeController.sink;
  Stream<bool> get themeStream => _themeController.stream;

  void darkTheme(bool value) async {
    _darkTheme = value;
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setBool('themeStatus', _darkTheme);
  }

  void initTheme() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _darkTheme = _prefs.getBool("themeStatus");
    themeSink.add(_darkTheme == null ? 0 : _darkTheme);
  }

  @override
  void dispose() {
    _themeController.close();
  }
}
