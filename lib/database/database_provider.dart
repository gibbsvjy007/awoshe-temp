import 'package:Awoshe/constants.dart';
import 'package:Awoshe/models/upload_progress/UploadProgress.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  Database _db;
  final _dbFile = 'awoshe.db';
  static const _VERSION = 1;

  static const _TABLE_UPLOAD_PROGRESS = 'UploadProgress';
  static const _COLUMN_TYPE = 'type';
  static const _COLUMN_DATA = 'data';

  Future<void> initDatabase() async {
    String path = await getDatabasesPath();

    path = join(path, _dbFile);

    if (_db == null) {
      _db = await openDatabase(
        path,
        onCreate: _onCreateDb,
        version: _VERSION,
      );
    }
  }

  Future<void> _onCreateDb(Database db, int version) async {
    String sql = 'CREATE TABLE '
        '$_TABLE_UPLOAD_PROGRESS ($_COLUMN_TYPE INTEGER PRIMARY KEY, $_COLUMN_DATA TEXT)';

    await db.execute(sql);
//    print('Database created');
  }

  Future<List<UploadProgress>> loadData() async {
    try {
      List<Map<String, dynamic>> tableRecords =
          await _db.query(_TABLE_UPLOAD_PROGRESS);

      print('LOAD LOCAL DATABASE OK! ${tableRecords.length}');
      if (tableRecords.isEmpty) return [];

      return tableRecords
          .map<UploadProgress>((record) => UploadProgress.fromJson(record))
          .toList();
    } catch (ex) {
      print('ERROR LOADING LOCAL DATABASE $ex');
      throw ex;
    }
  }

  Future<void> saveData(UploadProgress data) {
    return _db
        .insert(_TABLE_UPLOAD_PROGRESS, data.toJson(),
            conflictAlgorithm: ConflictAlgorithm.replace)
        .then((_) => print('insert ok $_'))
        .catchError((e) => print('Error in insert $e'));
  }

  void remove(ProductType type) {
    try {
      print('REMOVE $type');
      _db.delete(_TABLE_UPLOAD_PROGRESS,
          where: '$_COLUMN_TYPE = ?',
          whereArgs: [type.index]);
    } catch (ex) {
      print('No need delete data locally');
    }

  }

  void removeDatabase() async {
    String path = await getDatabasesPath();
    path = join(path, _dbFile);
    deleteDatabase(path);
  }
}
