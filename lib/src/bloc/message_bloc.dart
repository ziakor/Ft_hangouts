import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:ft_hangout/src/bloc/bloc.dart';
import 'package:ft_hangout/src/bloc/bloc_provider.dart';
import 'package:ft_hangout/src/bloc/sms_bloc.dart';
import 'package:ft_hangout/src/helpers/databaseHelper.dart';
import 'package:ft_hangout/src/models/message.dart';
import 'package:sqflite/sqflite.dart';

class MessageBloc implements Bloc {
  List<Map<String, dynamic>> _messageList = [];
  final _messageController =
      StreamController<List<Map<String, dynamic>>>.broadcast();
  List<Map<String, dynamic>> get messageList => _messageList;

  StreamSink<List<Map<String, dynamic>>> get messageSink =>
      _messageController.sink;
  Stream<List<Map<String, dynamic>>> get messageStream =>
      _messageController.stream;

  void sendMessage(Message message, BuildContext context, int idContact) async {
    try {
      Map data = await DatabaseHelper.instance.getContactdetail(idContact);
      BlocProvider.of<SmsBloc>(context).sendSms(data["phone"], message.message);
      int insertId = await DatabaseHelper.instance.insertMessage(message);
      _messageList.insert(0, {
        "id": insertId,
        "message": message.message,
        "time": message.time,
        "fromMe": message.fromMe,
      });
      messageSink.add(_messageList);
    } catch (e) {}
  }

  void newMessageReceived(String phone, String message, int time) async {
    try {
      print("$phone | $message | $time");
      int contactId =
          await DatabaseHelper.instance.getContactIdWithPhoneNumber(phone);
      if (contactId != null) {
        final Message newMessage = Message(
            message: message, time: time, idContact: contactId, fromMe: 0);
        int _insertId = await DatabaseHelper.instance.insertMessage(newMessage);
        _messageList.insert(0, {
          "id": _insertId,
          "message": message,
          "time": time,
          "fromMe": false,
        });
      }
    } catch (e) {
      return;
    }
    messageSink.add(_messageList);
  }

  void getMessage(int idContact) async {
    _messageList =
        List.from(await DatabaseHelper.instance.getMessages(idContact));
    messageSink.add(_messageList);
  }

  @override
  void dispose() {
    _messageController.close();
  }
}
