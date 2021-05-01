import 'dart:async';

import 'package:ft_hangout/src/bloc/bloc.dart';
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

  void sendMessage(Message message) async {
    int insertId = await DatabaseHelper.instance.insertMessage(message);
    _messageList.insert(0, {
      "id": insertId,
      "message": message.message,
      "time": message.time,
      "fromMe": message.fromMe,
    });
    messageSink.add(_messageList);
  }

  void getMessage(int idContact) async {
    _messageList =
        List.from(await DatabaseHelper.instance.getMessages(idContact));
    print("msg ${_messageList}");
    messageSink.add(_messageList);
  }

  @override
  void dispose() {
    _messageController.close();
  }
}
