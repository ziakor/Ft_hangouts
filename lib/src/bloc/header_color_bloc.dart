import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ft_hangout/src/bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HeaderColorBloc implements Bloc {
  Color _headerColor;
  final _colorList = [
    Colors.red,
    Colors.pink,
    Colors.purple,
    Colors.indigo,
    Colors.blue,
    Colors.lightBlue,
    Colors.cyan,
    Colors.teal,
    Colors.green,
    Colors.lightGreen,
    Colors.lime,
    Colors.yellow,
    Colors.amber,
    Colors.orange,
    Colors.deepOrange,
    Colors.grey,
  ];
  final _headerColorController = StreamController<Color>();

  Color get selectedHeaderColor => _headerColor;

  StreamSink<Color> get headerColorSink => _headerColorController.sink;
  Stream<Color> get headerColorStream => _headerColorController.stream;

  void changeHeaderColor(Color newColor) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.setInt("selectedHeaderColor", _colorList.indexOf(newColor));
    _headerColor = _colorList[_colorList.indexOf(newColor)];
    headerColorSink.add(_headerColor);
  }

  void initHeaderColor() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    final int index = _prefs.getInt("selectedHeaderColor") ?? -1;
    _headerColor = _colorList[index >= 0 ? index : 3];
    headerColorSink.add(_headerColor);
  }

  @override
  void dispose() {
    _headerColorController.close();
  }
}
