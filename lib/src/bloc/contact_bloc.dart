import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:ft_hangout/src/bloc/bloc.dart';
import 'package:ft_hangout/src/models/contact.dart';
import '../helpers/databaseHelper.dart';

class ContactBloc implements Bloc {
  List<Map<String, dynamic>> _contactList = [];
  final _contactController = StreamController<List<dynamic>>();
  List<dynamic> get contactList => _contactList;
  StreamSink<List<dynamic>> get contactSink => _contactController.sink;
  Stream<List<dynamic>> get contactStream => _contactController.stream;

  void getContactList() async {
    List<Map> tmp = await DatabaseHelper.instance.getContacts();
    tmp.forEach((element) => _contactList.add({
          "id": element["id"],
          "firstName": element["firstName"],
          "lastName": element["lastName"],
          "phone": element["phone"],
          "email": element["email"],
          "birthday": element["birthday"],
          "address": element["address"],
          "notes": element["notes"],
        }));
    contactSink.add(_contactList);
  }

  void addContact(Contact contact) async {
    await DatabaseHelper.instance.insertContact(contact);
    _contactList.add({
      "firstName": contact.firstName,
      "lastName": contact.lastName,
      "phone": contact.phone,
      "email": contact.email,
      "birthday": contact.birthday,
      "address": contact.address,
      "notes": contact.notes,
    });
    contactSink.add(_contactList);
  }

  void updateContactList(int idContact, String field, String value) {
    int index =
        _contactList.indexWhere((element) => element["id"] == idContact);
    _contactList[index][field] = value;
    contactSink.add(_contactList);
  }

  void removeContact(int id) async {
    await DatabaseHelper.instance.deleteContact(_contactList[id]["id"]);
    contactSink.add(_contactList);
  }

  @override
  void dispose() {
    _contactController.close();
  }
}
