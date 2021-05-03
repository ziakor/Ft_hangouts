import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:ft_hangout/src/bloc/bloc.dart';

class AppLifecycleBloc implements Bloc {
  DateTime _savedTime;
  final _appLifecycleController = StreamController<DateTime>.broadcast();

  DateTime get savedTime => _savedTime;

  StreamSink<DateTime> get appLifecycleSink => _appLifecycleController.sink;
  Stream<DateTime> get appLifecycleStream => _appLifecycleController.stream;

  void handleAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      _savedTime = DateTime.now();
    } else if (state == AppLifecycleState.resumed) {
      appLifecycleSink.add(_savedTime);
    }
  }

  void close() {
    if (_savedTime != null) {
      _savedTime = null;
      appLifecycleSink.add(_savedTime);
    }
  }

  @override
  void dispose() {
    _appLifecycleController.close();
  }
}
