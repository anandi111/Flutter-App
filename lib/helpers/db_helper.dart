import 'dart:typed_data';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:training_app/modals/student.dart';

Database? db;

class DBHelper {
  DBHelper._();
  static final DBHelper dbHelper = DBHelper._();

  ///TODO:initDB()
  Future<Database?> initDB() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'weaplinse_database.db');

    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE student (id INTEGER PRIMARY KEY, photo TEXT, name TEXT, email TEXT, phoneNumber INTEGER, password TEXT);');
    });

    return db!;
  }

  ///TODO:insertData()
  Future<int> insertData({
    required int id,
    String? photo,
    required String name,
    required String email,
    required int phoneNumber,
    required String password,
  }) async {
    db = await initDB();

    String query =
        "INSERT INTO student (id, photo, name, email, phoneNumber, password) VALUES(?, ?, ?, ?, ?, ?);";

    List args = [id, photo, name, email, phoneNumber, password];

    print("Insertion..");

    return await db!.rawInsert(query, args);
  }

  ///TODO:updateData()
  Future<int> updateData(
      {required int id,
      required String photo,
      required String name,
      required String email,
      required int phoneNumber,
      required String password}) async {
    db = await initDB();

    String query =
        "UPDATE student SET name = ?, photo = ?, email = ?, phoneNumber = ?, password = ? WHERE id = ?;";

    List args = [name, photo, email, phoneNumber, password, id];

    print("Updation..");

    return await db!.rawUpdate(query, args);
  }

  ///TODO:fetchAllData()
  Future<List<Student>> fetchAllData() async {
    db = await initDB();

    String query = "SELECT * FROM student;";

    List<Map<String, dynamic>> list =
        await db!.rawQuery("SELECT * FROM student");

    List<Student> studentList = [];

    list.map((e) => studentList.add(Student.formMap(map: e))).toList();

    print(studentList);

    return studentList;
  }

  ///TODO:deleteData()
  Future<int> deleteData({required int id}) async {
    db = await initDB();

    String query = "DELETE FROM student WHERE id = $id;";

    return await db!.rawDelete(query);
  }
}
