// ignore_for_file: depend_on_referenced_packages, avoid_print

import 'dart:async';

import 'package:path/path.dart' show join;
import 'package:sqflite/sqflite.dart';

class SqfLite {
  static Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await initialDatabase();
      return _db;
    } else {
      return _db;
    }
  }

  Future<Database> initialDatabase() async {
    String defaultPath = await getDatabasesPath();

    String path = join(defaultPath, "eat_at_home.db");

    Database mydb = await openDatabase(path, onCreate: _onCreate, version: 1);

    return mydb;
  }

  FutureOr<void> _onCreate(Database mydb, int version) async {
    mydb.execute('''
    CREATE TABLE cart (
    "tr_id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "user_id" INTEGER,
    "meal_id" INTEGER NOT NULL,
    "count" INTEGER NOT NULL,
    "price" REAL NOT NULL,
    "name" TEXT NOT NULL,
    "sub_price" REAL NOT NULL,
    "img" TEXT NOT NULL,
    "category" TEXT NOT NULL
    )
    ''');

    /*
    ''' 
    CREATE TABLE "notes" (
      "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
      "note" TEXT NOT NULL
    )
    '''
    
     */
    print("Created");
  }

  Future<List<Map>> selectData(String sql) async {
    Database? mydb = await db;

    List<Map> response = await mydb!.rawQuery(sql);

    return response;
  }

  Future<int> insertData(String sql) async {
    print("**************insert*********");

    Database? mydb = await db;

    int response = await mydb!.rawInsert(sql);

    return response;
  }

  Future<int> deleteData(String sql) async {
    Database? mydb = await db;

    int response = await mydb!.rawDelete(sql);

    return response;
  }

  Future<int> updateData(String sql) async {
    Database? mydb = await db;

    int response = await mydb!.rawUpdate(sql);

    return response;
  }
}
