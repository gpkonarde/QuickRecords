import 'dart:convert';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DatabaseHelper {
  static const String dbName = 'your_database.db';
  static const String tableName = 'user_data';

  late Database _database;

  Future<void> init() async {
    print('Initializing db');
    await initDatabase();
    print('Sync data from sharedPref');
    await syncDataFromSharedPreferences();
  }

  Future<void> initDatabase() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), dbName),
      onCreate: (db, version) {
        return db.execute(
          '''
          CREATE TABLE $tableName (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            aadhar TEXT,
            name TEXT,
            mobile TEXT,
            bank TEXT,
            amount TEXT
          )
          ''',
        );
      },
      version: 1,
    );
  }

  Future<void> insertUserData(Map<String, dynamic> userData) async {
    await _database.insert(tableName, userData);
  }

  Future<List<Map<String, dynamic>>> getAllUserData() async {
    return await _database.query(tableName);
  }

  Future<void> syncDataFromSharedPreferences() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? userDataString = sharedPreferences.getString('userdata');

    if (userDataString != null) {
      Map<String, dynamic> userData = jsonDecode(userDataString);
      await insertUserData(userData);
    }
  }
}
