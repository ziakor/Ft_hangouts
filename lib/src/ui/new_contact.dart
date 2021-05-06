import 'package:flutter/material.dart';
import 'package:ft_hangout/localization/language/languages.dart';
import 'package:ft_hangout/src/bloc/PausedTime.dart';
import 'package:ft_hangout/src/bloc/bloc_provider.dart';
import 'package:ft_hangout/src/bloc/contact_bloc.dart';
import 'package:ft_hangout/src/models/contact.dart';
import 'package:ft_hangout/src/ui/components/time_paused.dart';

class NewContact extends StatefulWidget {
  NewContact({Key key}) : super(key: key);
  @override
  _NewContactState createState() => _NewContactState();
}

class _NewContactState extends State<NewContact> {
  bool _submitIsDisabled = true;
  Map _contactData = {
    "firstName": null,
    "lastName": null,
    "phone": null,
    "email": null,
    "birthday": null,
    "address": null,
    "notes": null
  };
  final _formKey = GlobalKey<FormState>();
  TextEditingController _controller = new TextEditingController();
  FocusNode _birthdayNode = new FocusNode();
  DateTime _selectedDate = DateTime.now();
  _validatorSubmit(List<String> data) {
    if (data.every((element) => element != null && element.isEmpty == false)) {
      setState(() {
        _submitIsDisabled = false;
      });
    } else
      setState(() {
        _submitIsDisabled = true;
      });
  }

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

  bool _validateEmail(String value) {
    String pattern =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    RegExp regExp = new RegExp(pattern);
    if (value.length > 0) {
      if (!regExp.hasMatch(value)) return false;
    }
    return true;
  }

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate, // Refer step 1
      firstDate: DateTime(1900),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != _selectedDate)
      setState(() {
        _contactData["birthday"] =
            "${picked.day}/${picked.month}/${picked.year}";
        _controller.text = "${picked.day}/${picked.month}/${picked.year}";
      });
  }

  _newContact(BuildContext context) async {
    BlocProvider.of<ContactBloc>(context).addContact(Contact(
      firstName: _contactData["firstName"],
      lastName: _contactData["lastName"],
      phone: _contactData["phone"],
      email: _contactData["email"],
      birthday: _contactData["birthday"],
      address: _contactData["address"],
      notes: _contactData["notes"],
    ));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text(Languages.of(context).newContactTitle),
          actions: [
            IconButton(
              icon: Icon(Icons.check),
              onPressed: _submitIsDisabled
                  ? null
                  : () {
                      _newContact(context);
                    },
            )
          ],
        ),
        body: Container(
          child: GestureDetector(
            onTap: () => BlocProvider.of<PausedTimeBloc>(context).close(),
            child: Container(
              constraints: BoxConstraints.expand(),
              child: Form(
                autovalidateMode: AutovalidateMode.always,
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      TimePaused(),
                      ListTile(
                        contentPadding: EdgeInsets.fromLTRB(16, 10, 16, 0),
                        title: TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText:
                                "${Languages.of(context).labelFirstName}*",
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty)
                              return Languages.of(context).invalidFirstName;
                            return null;
                          },
                          onChanged: (value) {
                            _contactData["firstName"] = value;
                            _validatorSubmit(
                              [
                                _contactData["firstName"],
                                _contactData["phone"],
                              ],
                            );
                          },
                        ),
                      ),
                      ListTile(
                        title: TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: Languages.of(context).labelLastName,
                          ),
                          onChanged: (value) {
                            _contactData["lastName"] = value;
                          },
                        ),
                      ),
                      ListTile(
                        title: TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText:
                                "${Languages.of(context).labelPhoneNumber}*",
                          ),
                          validator: (value) {
                            return _validateMobilePhone(value, context);
                          },
                          onChanged: (value) {
                            _contactData["phone"] = value;
                            _validatorSubmit(
                              [
                                _contactData["firstName"],
                                _contactData["phone"],
                              ],
                            );
                          },
                        ),
                      ),
                      ListTile(
                        title: TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: Languages.of(context).labelEmail,
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
                        ),
                      ),
                      ListTile(
                        title: TextFormField(
                          controller: _controller,
                          focusNode: _birthdayNode,
                          readOnly: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText:
                                "${Languages.of(context).labelBirthday} DD/MM/AAAA",
                            suffixIcon: IconButton(
                                iconSize: 40,
                                tooltip: "Select date",
                                icon: Icon(
                                  Icons.date_range_outlined,
                                  color: Theme.of(context).primaryColor,
                                ),
                                onPressed: () {
                                  _selectDate(context);
                                }),
                          ),
                          onChanged: (value) {
                            _contactData["birthday"] = value;
                          },
                          onTap: () {
                            _birthdayNode.unfocus();
                            _birthdayNode.canRequestFocus = false;
                          },
                        ),
                      ),
                      ListTile(
                        title: TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: Languages.of(context).labelAddress,
                          ),
                          onChanged: (value) {
                            _contactData["address`"] = value;
                          },
                        ),
                      ),
                      ListTile(
                        title: TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: Languages.of(context).labelNotes,
                          ),
                          onChanged: (value) {
                            _contactData["notes"] = value;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
