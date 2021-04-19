import 'package:flutter/foundation.dart';

class Message {
  int id;
  String message;
  int time;
  int idContact;

  Message(
      {this.id,
      @required this.message,
      @required this.time,
      @required this.idContact});

  Map<String, dynamic> toMap() {
    return {'id': id, 'message': message, 'time': time, 'idContact': idContact};
  }
}
