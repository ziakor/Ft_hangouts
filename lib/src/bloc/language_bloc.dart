import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:ft_hangout/localization/locale_constant.dart';
import 'package:ft_hangout/src/bloc/bloc.dart';

class LanguageBloc implements Bloc {
  Locale get selectedLocale => _locale;
  Locale _locale;

  final _languageController = StreamController<Locale>();
  StreamSink<Locale> get localeSink => _languageController.sink;

  Stream<Locale> get localeStream => _languageController.stream;

  // LanguageBloc() {
  //   _localeController.stream.listen(changeLanguage);
  // }

  void changeLanguage(String languageCode) {
    setLocale(languageCode);
    _locale = Locale(languageCode, '');
    localeSink.add(_locale);
  }

  void initLanguage() async {
    _locale = await getLocale();
    localeSink.add(_locale);
  }

  @override
  void dispose() {
    _languageController.close();
  }
}
