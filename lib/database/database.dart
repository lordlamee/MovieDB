import 'package:flutter/cupertino.dart';
import 'package:movie_app/provider/downloads_provider.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:movie_app/models/download_model.dart';

class DatabaseProvider {
  static const String TABLE_DOWNLOADS = "downloads";
  static const String COLUMN_ID = "id";
  static const String COLUMN_NAME = "name";
  static const String COLUMN_PATH = "path";
  DatabaseProvider._();
  static final db = DatabaseProvider._();
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
    final Database database = await openDatabase(
      join(documentDirectory.path, "downloadsDB.db"),
      version: 1,
      onCreate: (Database database, int version) async {
        await database.execute("CREATE TABLE $TABLE_DOWNLOADS("
            "$COLUMN_ID INTEGER PRIMARY KEY,"
            "$COLUMN_NAME TEXT,"
            "$COLUMN_PATH TEXT"
            ")");
      },
    );
    return database;
  }

  onCreate(Database database, int version) async {
    await database.execute("CREATE IF TABLE NOT EXISTS $TABLE_DOWNLOADS("
        "$COLUMN_ID INTEGER PRIMARY KEY,"
        "$COLUMN_NAME TEXT,"
        "$COLUMN_PATH TEXT"
        ")");
  }

  saveDownload(Download download) async {
    Database db = await database;
    download.id = await db.insert(TABLE_DOWNLOADS, download.toMap());
    return download;
  }

  getDownloads(BuildContext context) async {
    final db = await database;
    var downloadsDatabase = await db
        .query(TABLE_DOWNLOADS, columns: [COLUMN_ID, COLUMN_NAME, COLUMN_PATH]);
    List<Download> downloads = List<Download>();
    downloadsDatabase.forEach((eachDownload) {
      Download download = Download.fromMap(eachDownload);
      downloads.add(download);
    });
    if (downloads != null && downloads.isNotEmpty) {
      Provider.of<DownloadsProvider>(context, listen: false)
          .setDownloads(downloads);
    }
  }
}
