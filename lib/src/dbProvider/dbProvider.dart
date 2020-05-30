import 'package:news/src/models/itemModels.dart';
import 'package:news/src/repository.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'package:path/path.dart';

class DbProvider implements Source,Cache{
  Future<List<int>>fetchTopIds()=>null;
  Database db;

  DbProvider(){
    init();
  }

  void init() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'items.db');
    db = await openDatabase(path, version: 1,
        onCreate: (Database newdb, int version) {
      newdb.execute("""
        CREATE TABLE Items
        (
          id INTEGER PRIMARY KEY,
          type TEXT,
          by TEXT,
          time TEXT,
          parent TEXT,
          kids BLOB,
          dead INTEGER,
          deleted INTEGER,
          url TEXT,
          score INTEGER,
          title TEXT,
          descendants INTEGER
        )
        """);
    });
  }

  Future<ItemModel> fetchItem(int id)async {
    final maps = await db.query(
      "Items",
      columns: null,
      where: "id=?",
      whereArgs: [id],
    );

    if (maps.length > 0) {
      return ItemModel.fromDb(maps.first);
    }
    return null;
  }

  Future<int> addItem(ItemModel item){
    return db.insert("Items", item.toMapForDb());
  }
}

final DbProvider dbProvider= DbProvider();
