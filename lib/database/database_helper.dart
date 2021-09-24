// the code below is used to create a file to act as the database helper
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  // the code below is used to create an instance of the DatabaseHelper.internal()
  static final DatabaseHelper _instance = DatabaseHelper.internal();

  // using the factory method
  factory DatabaseHelper() => _instance;

  // the code below is used to create a static instance of the Database
  static Database? _db;

  // the code below is used to create a getter method to get the db
  Future<Database> get db async {
    // the code below is used to check that if the db is not null the n returning
    // the db else using initDb method to create a database
    if (_db != null) {
      return _db!;
    }
    // if the db is null that means the db does not exists  so creating a db us using
    // the initDb method created below
    _db = await initDb();
    //  the code below is used to return the database
    return _db!;
  }

  DatabaseHelper.internal();

  // TODO: if any error occurs while creating the database then check the method below

  // the code below is used to create a method for creating a database if the databse
  // does not exists
  initDb() async {
    // the code below is used to get access to the application document directory
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    // the code below is used to create a variable to store the path of the database
    String path = join(documentDirectory.path, "new_appentus_flutter.db");

    // // the code below is used to get the database from the data folder
    // ByteData data = await rootBundle.load(join('data', 'appentus_data.db'));

    // List<int> bytes =
    //     data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

    // // the code below is used to copy the data from the assets to the documents
    // await File(path).writeAsBytes(bytes);

    // // the code below is used to open the database
    var ourDb = await openDatabase(path, version: 1, onCreate: createTable);

    // the code below is used to return the opened database
    return ourDb;
  }

  // the code below is used to create a method to create a table for the user
  Future<void> createTable(Database database, int version) async {
    // var res = await database.execute("""
    //   CREATE TABLE User(
    //     id TEXT PRIMARY KEY,
    //     userName TEXT,
    //     userEmail TEXT,
    //     userPassword TEXT,
    //     userPhoneNumber TEXT,
    //     userImage TEXT
    //   )""");
    // var res = await database.execute("""
    //   CREATE TABLE User(
    //     userEmail TEXT,
    //     userPassword TEXT
    //   )""");
    var res = await database.execute("""
      CREATE TABLE User(
        id TEXT PRIMARY KEY,
        userName TEXT,
        userEmail TEXT,
        userPassword TEXT,
        userPhoneNumber TEXT,
        userImage TEXT
      )""");
    return res;
  }
}
