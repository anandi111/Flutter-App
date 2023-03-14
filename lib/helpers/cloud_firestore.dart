import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class CloudFireStoreHelper {
  CloudFireStoreHelper._();
  static final CloudFireStoreHelper cloudFireStoreHelper = CloudFireStoreHelper._();
  final Reference ref = FirebaseStorage.instance.ref();

  ///TODO: add file
  Future<Response> addFile({required File file, required String fileName}) async {
    Response response = Response();

    await ref.child(fileName).putFile(file).then((p0) {
      response.code = 200;
      response.message = "Successfully image added..";
    }).onError((error, stackTrace) {
      response.code = 200;
      response.message = error.toString();
    });

    return response;
  }

  ///TODO: remove file
  Future<Response> removeFile({required String fileName}) async {
    Response response = Response();

    await ref.child(fileName).delete().then((p0) {
      response.code = 200;
      response.message = "Successfully image added..";
    }).onError((error, stackTrace) {
      response.code = 200;
      response.message = error.toString();
      print(error);
    });

    return response;
  }

  ///TODO: display file
  Future<String?> displayFile({required String fileName}) async {
    String? urlPath = await ref.child(fileName).getDownloadURL();

    return urlPath;
  }
}

class Response {
  int? code;
  String? message;
  Response({this.code, this.message});
}
