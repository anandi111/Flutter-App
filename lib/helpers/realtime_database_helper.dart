import 'package:firebase_database/firebase_database.dart';
import 'package:training_app/modals/employee.dart';

class RealTimeDataBaseHelper {
  RealTimeDataBaseHelper._();
  static final RealTimeDataBaseHelper realTimeDataBase = RealTimeDataBaseHelper._();

  ///TODO:write data
  Future<void> writeBySet({required Employee employee}) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("data/${employee.number}");

    await ref.set({
      "id": employee.id,
      "name": employee.name,
      "email": employee.email,
      "number": employee.number,
      "designation": employee.designation,
      "salary": employee.salary,
      "gender": employee.gender
    });
  }

  Future<void> writeByPush({required Employee employee, required String path}) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("data/").push();

    await ref.set({
      "id": ref.key,
      "name": employee.name,
      "email": employee.email,
      "number": employee.number,
      "designation": employee.designation,
      "salary": employee.salary,
      "gender": employee.gender,
      "path": path
    });
  }

  ///TODO:read data
  Query read() {
    Query ref = FirebaseDatabase.instance.ref().child("data");

    return ref;
  }

  ///TODO:update data
  Future<void> update({required Employee employee, required String path}) async {
    await FirebaseDatabase.instance.ref("data").child(employee.id).update({
      "id": employee.id,
      "name": employee.name,
      "email": employee.email,
      "number": employee.number,
      "designation": employee.designation,
      "salary": employee.salary,
      "gender": employee.gender,
      "path": path
    });
  }

  ///TODO:delete data
  Future<void> delete({required String id}) async {
    await FirebaseDatabase.instance.ref("data").child(id).remove();
  }
}
