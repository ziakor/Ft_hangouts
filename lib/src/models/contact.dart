import 'package:flutter/foundation.dart';

class Contact {
  final int id;
  final String firstName;
  final String lastName;
  final String phone;
  final String email;
  final String address;
  final String birthday;
  final String notes;

  Contact({
    this.id,
    @required this.firstName,
    @required this.lastName,
    @required this.phone,
    @required this.email,
    @required this.address,
    @required this.birthday,
    @required this.notes,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'phone': phone,
      'email': email,
      'address': address,
      'birthday': birthday,
      'notes': notes,
    };
  }
}
