import 'dart:async';
import 'dart:io';

import 'package:login/models/todo.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'package:sqflite/sqflite.dart';


class DiaryDatabase {
  static final DiaryDatabase _instance = DiaryDatabase._();
  static Database _database;

  DiaryDatabase._();

  factory DiaryDatabase() {
    return _instance;
  }

  Future<Database> get db async {
    if (_database != null) {
      return _database;
    }

    _database = await init();

    return _database;
  }

  Future<Database> init() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String dbPath = join(directory.path, 'TestDB.db');
    var database = openDatabase(dbPath, version: 1, onCreate: _onCreate, onUpgrade: _onUpgrade);

    return database;
  }

  void _onCreate(Database db, int version) {

      db.execute ("CREATE TABLE diary ("
          "id INTEGER PRIMARY KEY,"
          "message TEXT"
          ")");

  
    print("Database was created!");
  }



  void _onUpgrade(Database db, int oldVersion, int newVersion) {
    // Run migration according database versions
  }

  Future<int> addDiary(Diary x) async {

    var client = await db;
    return client.insert('diary', x.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }


  Future<List<Diary>> fetchAll() async {
    var client = await db;
    var res = await client.query('diary');
    

    if (res.isNotEmpty) {
      var diary = res.map((x) => Diary.fromMap(x)).toList();
      return diary;
    }
    return [];
  }



   
    



  
  Future<void> removeDiary(int id) async {
    var client = await db;
    return client.delete('diary', where: 'id = ?', whereArgs: [id]);
  }
  




  Future<void> removeAll() async {
    var client = await db;
    return client.delete('diary');
  }

  
  

  Future closeDb() async {
    var client = await db;
    client.close();
  }
}


