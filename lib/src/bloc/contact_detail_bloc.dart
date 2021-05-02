import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:ft_hangout/src/bloc/bloc.dart';
import 'package:ft_hangout/src/bloc/bloc_provider.dart';
import 'package:ft_hangout/src/bloc/contact_bloc.dart';
import 'package:ft_hangout/src/helpers/databaseHelper.dart';

class ContactDetailBloc implements Bloc {
  Map _contactData = {
    "firstName": "",
    "lastName": "",
    "phone": "",
    "email": "",
    "birthday": "",
    "address": "",
    "notes": ""
  };
  final _contactDataController = StreamController<Map>();
  Map get contactData => _contactData;
  StreamSink<Map> get contactDataSink => _contactDataController.sink;
  Stream<Map> get contactDataStream => _contactDataController.stream;

  void updateContact(
      String field, String value, int id, BuildContext context) async {
    print("$field | $value | $id");

    var response =
        await DatabaseHelper.instance.updateContact(field, value, id);
    if (response != null) {
      BlocProvider.of<ContactBloc>(context).updateContactList(id, field, value);
      _contactData[field] = value;
      contactDataSink.add(_contactData);
    } else {
      //adderror
      _contactData[field] = value;
      contactDataSink.add(_contactData);
    }
  }

  void getContactDetail(int idContact) async {
    var data = await DatabaseHelper.instance.getContactdetail(idContact);

    _contactData = {
      "firstName": data["firstName"] ?? "",
      "lastName": data["lastName"] ?? "",
      "phone": data["phone"] ?? "",
      "email": data["email"] ?? "",
      "birthday": data["birthday"] ?? "",
      "address": data["address"] ?? "",
      "notes": data["address"] ?? "",
    };
    contactDataSink.add(_contactData);
  }

  @override
  void dispose() {
    _contactDataController.close();
  }
}
