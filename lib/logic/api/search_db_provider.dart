import 'dart:io';

import 'package:Awoshe/models/search/search_result_item.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

//A singleton class
class SearchDbProvider {
  SearchDbProvider._();

  static final SearchDbProvider db = SearchDbProvider._();

  Database _db;

  Future<Database> get _database async {
    if (_db != null) return _db;
    // if _db is null we instantiate it
    _db = await init();
    return _db;
  }

  Future<Database> init() async {
    final Directory appDirectory = await getApplicationDocumentsDirectory();
    final dbPath = join(appDirectory.path, 'recentSearches.db');
    print("____________init LOCAL DB___________");
    return await openDatabase(dbPath, version: 5,
        onCreate: (Database newDb, int version) async {
          await newDb.execute('''
            CREATE TABLE RecentSearches
              (
                id TEXT PRIMARY KEY,
                title TEXT,
                itemId TEXT,
                description TEXT,
                imageUrl TEXT,
                currency TEXT,
                price TEXT
              )
          ''');
        });
  }

  Future<List<SearchResultItem>> fetchRecentSearch() async {
    final Database database = await _database;
    var res = await database.query('RecentSearches');
    final List<SearchResultItem> users =
    res.isNotEmpty ? res.map((r) => SearchResultItem.fromDB(r)).toList() : [];

    return users;
  }

  addSearch(SearchResultItem item) async {
    final Database database = await _database;
    final int v = await database.getVersion();
    print(v);
    print(item.toMapForDb());
    final Directory appDirectory = await getApplicationDocumentsDirectory();
    final dbPath = join(appDirectory.path, 'recentSearches.db');
//    await deleteDatabase(dbPath);
    print(dbPath);
    int id = await database.insert(
      'RecentSearches',
      item.toMapForDb(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print(id);
    return id;
  }

  removeSearch(SearchResultItem item) async {
    final Database database = await _database;

    return database.delete(
      'RecentSearches',
      where: "id = ?",
      whereArgs: [item.id],
    );
  }

  void close() {
    _db.close();
    _db = null;
  }
}
