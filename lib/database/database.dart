import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:movie_app/models/download_model.dart';

class DatabaseProvider {
  DatabaseProvider._();
  final db = DatabaseProvider._();
  Database _database;
  Future<Database> get database async {
    if (_database != null) {
      return _database;
    } else {
      _database = await getDb();
      return _database;
    }
  }

  getDb() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    final Future<Database> database = openDatabase(
        join(documentDirectory.path, "downloads_db.db"),
        version: 1,
        onCreate: (db, int) {});
    return database;
  }

  onCreate(Database database, int version) async {
    await database.execute("CREATE IF TABLE NOT EXISTS downloads("
        "id INTEGER PRIMARY KEY,"
        "name TEXT,"
        "path TEXT,"
        ")");
  }

  saveDownload(Download download) async {
    Database db = await getDb();
    int downloadId = await db.insert("downloads_db", download.toMap());
    return downloadId;
  }
}
