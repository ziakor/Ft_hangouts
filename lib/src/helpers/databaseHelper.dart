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
      `notes` TEXT
      );''');
    await db.execute(''' CREATE TABLE `Message` (
        `id` INTEGER PRIMARY KEY,
        `message` INT NOT NULL,
        `time` INT NOT NULL,
        `fromMe` INT NOT NULL,
        `idContact` INT NOT NULL
      );''');
  }

//! CONTACT
  Future<int> insertContact(Contact contact) async {
    Database db = await instance.database;

    return db.rawInsert(
      'INSERT INTO Contact(firstName, lastName, phone, email, address, birthday, notes) VALUES (?, ?, ?, ?, ?, ?, ?)',
      [
        contact.firstName,
        contact.lastName,
        contact.phone,
        contact.email,
        contact.address,
        contact.birthday,
        contact.notes,
      ],
    ).then((value) {
      return value;
    }).catchError((value) {
      return -1;
    });
  }

  Future<int> updateContact(String field, String value, int id) async {
    Database db = await instance.database;
    return db.rawUpdate(
      "UPDATE Contact SET $field = ? WHERE id = ?",
      [
        value,
        id,
      ],
    ).then((value) {
      return value;
    }).catchError((value) {
      return -1;
    });
  }

  Future<int> deleteContact(int contactId) async {
    Database db = await instance.database;

    await db.rawDelete("DELETE  FROM Message WHERE idContact = ?", [contactId]);
    return db.rawDelete("DELETE FROM Contact WHERE id = ?", [contactId]).then(
        (value) {
      return value;
    }).catchError((value) {
      return -1;
    });
  }

  Future<List<Map>> getContacts() async {
    Database db = await instance.database;
    // String path = join(await getDatabasesPath(), _databaseName);
    // deleteDatabase(path);
    try {
      var res = await db
          .rawQuery("SELECT id, firstName, lastName, phone FROM Contact ");

      return res;
    } catch (e) {
      return [];
    }
  }

  Future<int> getContactIdWithPhoneNumber(String phone) async {
    Database db = await instance.database;

    if (phone.startsWith("+33")) {
      String _tmpPhone = phone.replaceAll("+33", "0");
      var res = await db
          .rawQuery("SELECT id FROM Contact WHERE phone = ?", [_tmpPhone]);
      if (res.length > 0) {
        return res[0]["id"];
      }
    }
    try {
      var res =
          await db.rawQuery("SELECT id FROM Contact WHERE phone = ?", [phone]);

      return (res.length == 1 ? res[0]["id"] : null);
    } catch (e) {
      return null;
    }
  }

  Future<Map> getContactdetail(int idContact) async {
    Database db = await instance.database;

    try {
      var res =
          await db.rawQuery("SELECT * FROM Contact WHERE id = ?", [idContact]);
      if (res.length > 0) {
        return (res[0]);
      } else
        return null;
    } catch (e) {
      return null;
    }
  }

//! MESSAGE
  Future<int> insertMessage(Message message) async {
    Database db = await instance.database;

    return db.rawInsert(
      'INSERT INTO Message(message, time, idContact, fromMe) VALUES(?, ?, ?, ?)',
      [message.message, message.time, message.idContact, message.fromMe],
    ).then((value) {
      return value;
    }).catchError((value) {
      return -1;
    });
  }

  Future<List<Map>> getMessages(int idContact) async {
    Database db = await instance.database;
    try {
      var res = await db.rawQuery(
          "SELECT id, message, time, idContact, fromMe FROM Message WHERE idcontact = ? ORDER BY id DESC",
          [idContact]);
      return res;
    } catch (e) {
      return [];
    }
  }
}
