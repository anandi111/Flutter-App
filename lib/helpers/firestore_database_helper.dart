import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart';
import 'package:training_app/modals/todo.dart';

class FireStoreDataBaseHelper {
  FireStoreDataBaseHelper._();
  static final FireStoreDataBaseHelper fireStoreDataBaseHelper = FireStoreDataBaseHelper._();

  final FirebaseFirestore fireStore = FirebaseFirestore.instance;

  //TODO:add data
  Future<Response> addData({required TODO todo}) async {
    Response response = Response();
    DocumentReference documentReference = fireStore.collection("todo").doc();

    await documentReference.set({
      "id": documentReference.id,
      "title": todo.title,
      "description": todo.description,
      "createDate": todo.createDate,
      "doneDate": todo.doneDate,
      "status": todo.status,
    }).whenComplete(() {
      response.code = 200;
      response.message = "Successfully added to the database";
    }).catchError((e) {
      response.code = 500;
      response.message = e;
    });

    return response;
  }

  //TODO:read data
  Stream<QuerySnapshot<Object?>>? readData() {
    return fireStore.collection("todo").snapshots();
  }

  List<TODO> getData({required List data}) {
    List<TODO> todoList = [];

    for (int i = 0; i < data.length; i++) {
      todoList.add(TODO(
          id: data[i]["id"],
          title: data[i]["title"],
          description: data[i]["description"],
          createDate: data[i]["createDate"],
          doneDate: data[i]["doneDate"],
          status: data[i]["status"]));
    }

    return todoList;
  }

  //TODO:delete data
  Future<Response> deleteData({required String id}) async {
    Response response = Response();

    await fireStore.collection("todo").doc(id).delete().whenComplete(() {
      response.code = 200;
      response.message = "Successfully deleted from the database";
    }).catchError((e) {
      response.code = 500;
      response.message = e;
    });

    return response;
  }

  //TODO:update data
  Future<Response> updateData({required TODO todo}) async {
    Response response = Response();

    await fireStore.collection("todo").doc(todo.id).update({
      "id": todo.id,
      "title": todo.title,
      "description": todo.description,
      "createDate": todo.createDate,
      "doneDate": todo.doneDate,
      "status": todo.status,
    }).whenComplete(() {
      response.code = 200;
      response.message = "Successfully updated from the database";
    }).catchError((e) {
      response.code = 500;
      response.message = e;
    });

    return response;
  }

  //TODO:search data
}

class Response {
  int? code;
  String? message;
  Response({this.code, this.message});
}
