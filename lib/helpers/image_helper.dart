import 'dart:typed_data';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:training_app/modals/music.dart';

Database? db;

class ImageDBHelper {
  ImageDBHelper._();
  static final ImageDBHelper imageDBHelper = ImageDBHelper._();

  ///TODO:initDB()
  Future<Database?> initDB() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'weaplinse_database_image.db');

    db = await openDatabase(path, version: 1, onCreate: (Database db, int version) async {
      await db.execute('CREATE TABLE image (path TEXT);');
    });

    return db!;
  }

  ///TODO:insertData()
  Future<int> insertData({
    required String path,
  }) async {
    db = await initDB();

    String query = "INSERT INTO image (path) VALUES(?);";

    List args = [path];

    return await db!.rawInsert(query, args);
  }

  ///TODO:fetchAllData()
  Future<List<Map<String, dynamic>>> fetchAllData() async {
    db = await initDB();

    String query = "SELECT * FROM image;";

    List<Map<String, dynamic>> list = await db!.rawQuery(query);

    return list;
  }

  ///TODO:deleteData()
  Future<int> deleteData({required String path}) async {
    db = await initDB();

    String query = "DELETE FROM image WHERE path = ?;";

    List args = [path];

    return await db!.rawDelete(query, args);
  }
}
