import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:ft_hangout/localization/language/languages.dart';

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
    "phoneNumber": null,
    "email": null,
    "birthday": null,
    "notes": null
  };
  DateTime selectedDate = DateTime.now();
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

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Refer step 1
      firstDate: DateTime(1900),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        _contactData["birthday"] =
            "${picked.day}/${picked.month}/${picked.year}";
      });
    _controller.text = "${picked.day}/${picked.month}/${picked.year}";
  }

  TextEditingController _controller = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    print("selectedDate = $selectedDate");
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text(Languages.of(context).newContactTitle),
          actions: [
            IconButton(
              icon: Icon(Icons.check),
              onPressed: _submitIsDisabled ? null : () {},
            )
          ],
        ),
        body: Form(
          child: Column(
            children: [
              ListTile(
                contentPadding: EdgeInsets.fromLTRB(16, 10, 16, 0),
                title: TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "First name*",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return "Please enter the first name";
                    return null;
                  },
                  onChanged: (value) {
                    _contactData["firstName"] = value;
                    _validatorSubmit(
                      [
                        _contactData["firstName"],
                        _contactData["phoneNumber"],
                      ],
                    );
                  },
                ),
              ),
              ListTile(
                title: TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Last name",
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
                    labelText: "Phone number*",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return "Please enter the phone number";
                    return null;
                  },
                  onChanged: (value) {
                    _contactData["phoneNumber"] = value;
                    _validatorSubmit(
                      [
                        _contactData["firstName"],
                        _contactData["phoneNumber"],
                      ],
                    );
                  },
                ),
              ),
              ListTile(
                title: TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Email",
                  ),
                  onChanged: (value) {
                    _contactData["email"] = value;
                  },
                ),
              ),
              ListTile(
                title: TextFormField(
                  controller: _controller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Birthday DD/MM/AAAA",
                  ),
                  onChanged: (value) {
                    _contactData["birthday"] = value;
                  },
                ),
                trailing: IconButton(
                    iconSize: 40,
                    tooltip: "Select date",
                    icon: Icon(
                      Icons.date_range_outlined,
                    ),
                    onPressed: () {
                      _selectDate(context);
                    }),
              ),
              ListTile(
                title: TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Notes",
                  ),
                  onChanged: (value) {
                    _contactData["firstName"] = value;
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
