import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:ft_hangout/src/bloc/bloc.dart';
import 'package:ft_hangout/src/bloc/bloc_provider.dart';
import 'package:ft_hangout/src/bloc/message_bloc.dart';
import 'package:ft_hangout/src/models/message.dart';

class SmsBloc implements Bloc {
  static const _channel = MethodChannel("com.ft_hangouts/sms");
  Map _smsMessage = {"from": "", "message": ""};
  final _smsController = StreamController<Map>();
  Map get smsMessage => _smsMessage;
  StreamSink<Map> get smsSink => _smsController.sink;
  Stream<Map> get smsStream => _smsController.stream;

  void setupSmsReceived(BuildContext context) async {
    try {
      await _channel.invokeMethod("setupSmsReceived");

      _channel.setMethodCallHandler((call) {
        final Map args = call.arguments;
        switch (call.method) {
          case "smsReceived":
            BlocProvider.of<MessageBloc>(context).newMessageReceived(
                args["from"],
                args["message"],
                DateTime.now().millisecondsSinceEpoch);
            break;
          default:
        }
        return;
      });
    } on PlatformException catch (e) {
      print("smspermission: $e");
    }
  }

  void sendSms(String phone, String message) async {
    try {
      await _channel
          .invokeMethod("sendSms", {"phone": phone, "message": message});
    } on PlatformException catch (e) {
      print("smspermission: $e");
    }
  }

  Future<bool> smsPermission() async {
    try {
      final bool result = await _channel.invokeMethod("requestSmsPermission");
      return result;
    } on PlatformException catch (e) {
      print("smspermission: $e");
    }
    return false;
  }

  Future<void> initSmsPlatform(BuildContext context) async {
    try {
      if (await smsPermission()) {
        setupSmsReceived(context);
      }
    } catch (e) {}
  }

  @override
  void dispose() {
    _smsController.close();
  }
}
