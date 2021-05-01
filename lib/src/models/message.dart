import 'package:flutter/foundation.dart';

class Message {
  final int id;
  final String message;
  final int time;
  final int fromMe;
  final int idContact;

  Message({
    this.id,
    @required this.message,
    @required this.time,
    @required this.idContact,
    @required this.fromMe,
  });

  Map<String, dynamic> toMap() {
    return {'id': id, 'message': message, 'time': time, 'idContact': idContact};
  }
}
