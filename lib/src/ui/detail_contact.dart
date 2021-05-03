import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:ft_hangout/localization/language/languages.dart';
import 'package:ft_hangout/src/bloc/app_lifecycle.dart';
import 'package:ft_hangout/src/bloc/bloc_provider.dart';
import 'package:ft_hangout/src/bloc/contact_bloc.dart';
import 'package:ft_hangout/src/bloc/contact_detail_bloc.dart';

class DetailContactEditable extends StatefulWidget {
  final contactId;
  DetailContactEditable({Key key, @required this.contactId}) : super(key: key);

  @override
  _DetailContactEditableState createState() => _DetailContactEditableState();
}

class _DetailContactEditableState extends State<DetailContactEditable> {
  Map _contactData = {
    "firstName": "",
    "lastName": "",
    "phone": "",
    "email": "",
    "birthday": "",
    "address": "",
    "notes": ""
  };
  TextEditingController _birthdayFieldController = new TextEditingController();

  FocusNode _firstNameFieldNode = new FocusNode();
  FocusNode _lastNameFieldNode = new FocusNode();
  FocusNode _phoneFieldNode = new FocusNode();
  FocusNode _emailFieldNode = new FocusNode();
  FocusNode _birthdayFieldNode = new FocusNode();
  FocusNode _addressFieldNode = new FocusNode();
  FocusNode _notesFieldNode = new FocusNode();

  final _firstNameFormKey = GlobalKey<FormState>();
  final _lastNameFormKey = GlobalKey<FormState>();
  final _phoneFormKey = GlobalKey<FormState>();
  final _emailFormKey = GlobalKey<FormState>();
  final _birthdayFormKey = GlobalKey<FormState>();
  final _addressFormKey = GlobalKey<FormState>();
  final _notesFormKey = GlobalKey<FormState>();

  bool firstNameEdit = false;
  bool lastNameEdit = false;
  bool phoneEdit = false;
  bool emailEdit = false;
  bool addressEdit = false;
  bool birthDayEdit = false;
  bool notesEdit = false;
  DateTime _selectedDate = DateTime.now();

//update contact method

  _updatefirstName(BuildContext context, String newfirstName) {
    BlocProvider.of<ContactDetailBloc>(context)
        .updateContact("firstName", newfirstName, widget.contactId, context);
  }

  _updateLastName(BuildContext context, String newLastName) {
    BlocProvider.of<ContactDetailBloc>(context)
        .updateContact("lastName", newLastName, widget.contactId, context);
  }

  _updatePhone(BuildContext context, String newPhone) {
    BlocProvider.of<ContactDetailBloc>(context)
        .updateContact("phone", newPhone, widget.contactId, context);
  }

  _updateEmail(BuildContext context, String newEmail) {
    BlocProvider.of<ContactDetailBloc>(context)
        .updateContact("email", newEmail, widget.contactId, context);
  }

  _updateAddress(BuildContext context, String newAddress) {
    BlocProvider.of<ContactDetailBloc>(context)
        .updateContact("address", newAddress, widget.contactId, context);
  }

  _updateBirthday(BuildContext context, String newBirthday) {
    BlocProvider.of<ContactDetailBloc>(context)
        .updateContact("birthday", newBirthday, widget.contactId, context);
  }

  _updateNotes(BuildContext context, String newNotes) {
    BlocProvider.of<ContactDetailBloc>(context)
        .updateContact("notes", newNotes, widget.contactId, context);
  }

// validation method
  String _validateMobilePhone(String value, BuildContext context) {
    String pattern = r'(^\s*\+?\s*([0-9][\s-]*){9,}$)';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return Languages.of(context).invalidPhoneNumberEmpty;
    } else if (!regExp.hasMatch(value)) {
      return Languages.of(context).invalidPhoneNumber;
    }
    return null;
  }

  String _validatefirstName(String value) {
    if (value == null || value.isEmpty)
      return Languages.of(context).invalidFirstName;
    return null;
  }

  bool _validateEmail(String value) {
    String pattern =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    RegExp regExp = new RegExp(pattern);
    print("$value | ${regExp.hasMatch(value)}");
    if (value.length > 0) {
      if (!regExp.hasMatch(value)) return false;
    }
    return true;
  }

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != _selectedDate)
      _contactData["birthday"] = "${picked.day}/${picked.month}/${picked.year}";

    _birthdayFieldController.text =
        "${picked.day}/${picked.month}/${picked.year}";
  }

  _updateSelectDate(String date) {
    var _split = date.split("/");
    print(_split);
    if (_split.length == 3) {
      _selectedDate = DateTime(
          int.parse(_split[2]), int.parse(_split[1]), int.parse(_split[0]));
      _birthdayFieldController.text =
          "${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}";
    } else {
      _birthdayFieldController.text = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: BlocProvider.of<ContactDetailBloc>(context).contactDataStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.data == null) {
          BlocProvider.of<ContactDetailBloc>(context)
              .getContactDetail(widget.contactId);
          return CircularProgressIndicator();
        } else {
          _contactData = snapshot.data;
          _birthdayFieldController.text = _contactData["birthday"];
          _updateSelectDate(_contactData["birthday"]);
        }
        print("DATA: $_contactData");
        return Container(
          child: Scaffold(
            appBar: AppBar(
              title: Text(Languages.of(context).newContactTitle),
            ),
            body: GestureDetector(
              onTap: () => BlocProvider.of<AppLifecycleBloc>(context).close(),
              child: Container(
                constraints: BoxConstraints.expand(),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Form(
                        key: _firstNameFormKey,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: ListTile(
                          contentPadding: EdgeInsets.fromLTRB(16, 10, 16, 0),
                          title: TextFormField(
                            initialValue: _contactData["firstName"] ?? "",
                            readOnly: !firstNameEdit,
                            focusNode: _firstNameFieldNode,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: Icon(
                                  firstNameEdit ? Icons.check : Icons.edit,
                                  color: Theme.of(context).primaryColor,
                                ),
                                onPressed: firstNameEdit
                                    ? () {
                                        if (_firstNameFormKey.currentState
                                            .validate()) {
                                          _updatefirstName(context,
                                              _contactData["firstName"]);
                                          setState(
                                            () {
                                              firstNameEdit = false;
                                            },
                                          );
                                        }
                                      }
                                    : () {
                                        setState(
                                          () {
                                            firstNameEdit = true;
                                          },
                                        );
                                      },
                              ),
                              border: OutlineInputBorder(),
                              labelText:
                                  "${Languages.of(context).labelFirstName}*",
                            ),
                            validator: (value) => _validatefirstName(value),
                            onTap: () {
                              if (!firstNameEdit) {
                                _firstNameFieldNode.unfocus();
                                _firstNameFieldNode.canRequestFocus = false;
                              }
                            },
                            onChanged: (value) {
                              _contactData["firstName"] = value;
                            },
                          ),
                        ),
                      ),
                      Form(
                        key: _lastNameFormKey,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: ListTile(
                          title: TextFormField(
                            focusNode: _lastNameFieldNode,
                            initialValue: _contactData["lastName"],
                            readOnly: !lastNameEdit,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: Icon(
                                  lastNameEdit ? Icons.check : Icons.edit,
                                  color: Theme.of(context).primaryColor,
                                ),
                                onPressed: lastNameEdit
                                    ? () {
                                        _updateLastName(
                                            context, _contactData["lastName"]);
                                        setState(
                                          () {
                                            lastNameEdit = false;
                                          },
                                        );
                                      }
                                    : () {
                                        setState(
                                          () {
                                            lastNameEdit = true;
                                          },
                                        );
                                      },
                              ),
                              border: OutlineInputBorder(),
                              labelText: Languages.of(context).labelLastName,
                            ),
                            onTap: () {
                              if (!lastNameEdit) {
                                _lastNameFieldNode.unfocus();
                                _lastNameFieldNode.canRequestFocus = false;
                              }
                            },
                            onChanged: (value) {
                              _contactData["lastName"] = value;
                            },
                          ),
                        ),
                      ),
                      Form(
                        key: _phoneFormKey,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: ListTile(
                          title: TextFormField(
                            focusNode: _phoneFieldNode,
                            initialValue: _contactData["phone"],
                            readOnly: !phoneEdit,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText:
                                  "${Languages.of(context).labelPhoneNumber}*",
                              suffixIcon: IconButton(
                                icon: Icon(
                                  phoneEdit ? Icons.check : Icons.edit,
                                  color: Theme.of(context).primaryColor,
                                ),
                                onPressed: phoneEdit
                                    ? () {
                                        if (_phoneFormKey.currentState
                                            .validate()) {
                                          _updatePhone(
                                              context, _contactData["phone"]);
                                          setState(
                                            () {
                                              phoneEdit = false;
                                            },
                                          );
                                        }
                                      }
                                    : () {
                                        setState(
                                          () {
                                            phoneEdit = true;
                                          },
                                        );
                                      },
                              ),
                            ),
                            validator: (value) =>
                                _validateMobilePhone(value, context),
                            onChanged: (value) {
                              _contactData["phone"] = value;
                            },
                            onTap: () {
                              if (!phoneEdit) {
                                _phoneFieldNode.unfocus();
                                _phoneFieldNode.canRequestFocus = false;
                              }
                            },
                          ),
                        ),
                      ),
                      Form(
                        key: _emailFormKey,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: ListTile(
                          title: TextFormField(
                            focusNode: _emailFieldNode,
                            initialValue: _contactData["email"],
                            readOnly: !emailEdit,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: Languages.of(context).labelEmail,
                              suffixIcon: IconButton(
                                icon: Icon(
                                  emailEdit ? Icons.check : Icons.edit,
                                  color: Theme.of(context).primaryColor,
                                ),
                                onPressed: emailEdit
                                    ? () {
                                        _updateEmail(
                                            context, _contactData["email"]);
                                        setState(
                                          () {
                                            emailEdit = false;
                                          },
                                        );
                                      }
                                    : () {
                                        setState(
                                          () {
                                            emailEdit = true;
                                          },
                                        );
                                      },
                              ),
                            ),
                            validator: (value) {
                              if (!_validateEmail(value)) {
                                return Languages.of(context).invalidEmail;
                              }
                              return null;
                            },
                            onChanged: (value) {
                              _contactData["email"] = value;
                            },
                            onTap: () {
                              if (!emailEdit) {
                                _emailFieldNode.unfocus();
                                _emailFieldNode.canRequestFocus = false;
                              }
                            },
                          ),
                        ),
                      ),
                      Form(
                        key: _birthdayFormKey,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: ListTile(
                          title: TextFormField(
                            focusNode: _birthdayFieldNode,
                            readOnly: true,
                            controller: _birthdayFieldController,
                            decoration: InputDecoration(
                              prefixIcon: birthDayEdit
                                  ? IconButton(
                                      iconSize: 40,
                                      tooltip: "Select date",
                                      icon: Icon(
                                        Icons.date_range_outlined,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                      onPressed: () {
                                        _selectDate(context);
                                      })
                                  : null,
                              border: OutlineInputBorder(),
                              labelText:
                                  "${Languages.of(context).labelBirthday} DD/MM/AAAA",
                              suffixIcon: IconButton(
                                icon: Icon(
                                  birthDayEdit ? Icons.check : Icons.edit,
                                  color: Theme.of(context).primaryColor,
                                ),
                                onPressed: birthDayEdit
                                    ? () {
                                        _updateBirthday(
                                            context, _contactData["birthday"]);
                                        setState(
                                          () {
                                            birthDayEdit = false;
                                          },
                                        );
                                      }
                                    : () {
                                        setState(
                                          () {
                                            birthDayEdit = true;
                                          },
                                        );
                                      },
                              ),
                            ),
                            onChanged: (value) {
                              _contactData["birthday"] = value;
                            },
                            onTap: () {
                              _birthdayFieldNode.unfocus();
                              _birthdayFieldNode.canRequestFocus = false;
                            },
                          ),
                        ),
                      ),
                      Form(
                        key: _addressFormKey,
                        child: ListTile(
                          title: TextFormField(
                            focusNode: _addressFieldNode,
                            readOnly: !addressEdit,
                            initialValue: _contactData["address"],
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: Languages.of(context).labelAddress,
                              suffixIcon: IconButton(
                                icon: Icon(
                                  addressEdit ? Icons.check : Icons.edit,
                                  color: Theme.of(context).primaryColor,
                                ),
                                onPressed: addressEdit
                                    ? () {
                                        _updateAddress(
                                            context, _contactData["address"]);
                                        setState(
                                          () {
                                            addressEdit = false;
                                          },
                                        );
                                      }
                                    : () {
                                        setState(
                                          () {
                                            addressEdit = true;
                                          },
                                        );
                                      },
                              ),
                            ),
                            onChanged: (value) {
                              _contactData["address"] = value;
                            },
                            onTap: () {
                              if (!addressEdit) {
                                _addressFieldNode.unfocus();
                                _addressFieldNode.canRequestFocus = false;
                              }
                            },
                          ),
                        ),
                      ),
                      Form(
                        key: _notesFormKey,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: ListTile(
                          title: TextFormField(
                            focusNode: _notesFieldNode,
                            initialValue: _contactData["notes"],
                            readOnly: !notesEdit,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: Languages.of(context).labelNotes,
                              suffixIcon: IconButton(
                                icon: Icon(
                                  notesEdit ? Icons.check : Icons.edit,
                                  color: Theme.of(context).primaryColor,
                                ),
                                onPressed: notesEdit
                                    ? () {
                                        _updateNotes(
                                            context, _contactData["notes"]);
                                        setState(
                                          () {
                                            notesEdit = false;
                                          },
                                        );
                                      }
                                    : () {
                                        setState(
                                          () {
                                            notesEdit = true;
                                          },
                                        );
                                      },
                              ),
                            ),
                            onChanged: (value) {
                              _contactData["notes"] = value;
                            },
                            onTap: () {
                              if (!notesEdit) {
                                _notesFieldNode.unfocus();
                                _notesFieldNode.canRequestFocus = false;
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
