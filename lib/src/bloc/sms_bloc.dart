import 'dart:async';

import 'package:flutter/services.dart';
import 'package:ft_hangout/src/bloc/bloc.dart';

class SmsBloc implements Bloc {
  static const _channel = MethodChannel("com.ft_hangouts/sms");
  Map _smsMessage = {"from": "", "message": ""};
  final _smsController = StreamController<Map>();
  Map get smsMessage => _smsMessage;
  StreamSink<Map> get smsSink => _smsController.sink;
  Stream<Map> get smsStream => _smsController.stream;

  void listen() async {
    try {
      final String result = await _channel.invokeMethod("listenIncomingSms");
      print("resul :$result");
    } on PlatformException catch (e) {
      print("smspermission: ${e}");
    }
  }

  Future<bool> smsPermission() async {
    try {
      final bool result = await _channel.invokeMethod("requestSmsPermission");
      if (result) {
        listen();
        print("Talacces");
      } else
        print("tapalacces");
    } on PlatformException catch (e) {
      print("smspermission: ${e}");
    }
    return true;
  }

  @override
  void dispose() {
    _smsController.close();
  }
}
