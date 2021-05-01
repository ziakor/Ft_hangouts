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
    this.firstName,
    this.lastName,
    this.phone,
    this.email,
    this.address,
    this.birthday,
    this.notes,
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
