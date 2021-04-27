import 'dart:async';

import 'package:ft_hangout/src/models/message.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/contact.dart';

class DatabaseHelper {
  static final _databaseName = "Hangouts";
  static final _databaseVersion = 1;

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''CREATE TABLE `Contact` (
      `id` INTEGER PRIMARY KEY,
      `firstName` TEXT,
      `lastName` TEXT,
      `phone` TEXT,
      `email` TEXT,
      `address` TEXT,
      `birthday` TEXT,
      `image` TEXT,
      `notes` TEXT
      );
      CREATE TABLE `Message` (
        `id` INTEGER PRIMARY KEY,
        `message` INT NOT NULL,
        `Time` INT NOT NULL,
        `idContact` INT NOT NULL
      );''');
    print("Table is created!");
  }

// CONTACT
  Future<int> insertContact(Contact contact) async {
    Database db = await instance.database;

    return db.rawInsert(
      'INSERT INTO Contact(firstName, lastName, phone, email, address, birthday, image, notes) VALUES (?, ?, ?, ?, ?, ?, ?, ?)',
      [
        contact.firstName,
        contact.lastName,
        contact.phone,
        contact.email,
        contact.address,
        contact.birthday,
        contact.image,
        contact.notes,
      ],
    ).then((value) {
      return value;
    }).catchError((value) {
      print("error insert : $value");
      return -1;
    });
  }

  Future<int> updateContact(Contact contact) async {
    Database db = await instance.database;
    return db.rawUpdate(
      "UPDATE Contact SET firstName = ?, lastName = ?, phone = ?, email = ?, address = ?, birthday = ?, image = ?, notes = ? WHERE id = ?",
      [
        contact.firstName,
        contact.lastName,
        contact.phone,
        contact.email,
        contact.address,
        contact.address,
        contact.image,
        contact.notes,
        contact.id,
      ],
    ).then((value) {
      return value;
    }).catchError((value) {
      print("error update : $value");
      return -1;
    });
  }

  Future<int> deleteContact(int contactId) async {
    Database db = await instance.database;

    return db.rawDelete("DELETE FROM Contact WHERE id = ?", [contactId]).then(
        (value) {
      print(">>$value");
      return value;
    }).catchError((value) {
      print("error  delete contact : $value");
      return -1;
    });
  }

  Future<List<Map>> getContacts() async {
    Database db = await instance.database;
    // String path = join(await getDatabasesPath(), _databaseName);
    // deleteDatabase(path);
    try {
      var res = await db
          .rawQuery("SELECT id, firstName, lastName, phone FROM Contact");

      return res;
    } catch (e) {
      print("error getCOntact : $e");
      return [];
    }
  }

// END CONTACT

  Future<int> insertMessage(Message message) async {
    Database db = await instance.database;

    return db.rawInsert(
      "INSERT INTO Message(message,time,idContact) VALUES(?, ?, ?)",
      [message.message, message.time, message.idContact],
    ).then((value) {
      return value;
    }).catchError((value) {
      print("error insert : $value");
      return -1;
    });
  }

  Future<int> deleteMessage(int messageId) async {
    Database db = await instance.database;

    return db.rawDelete(
      "DELETE FROM Message WHERE id = ?",
      [messageId],
    ).then((value) {
      print(value);
      return value;
    }).catchError((value) {
      print("error delete : $value");
      return -1;
    });
  }

//
}
