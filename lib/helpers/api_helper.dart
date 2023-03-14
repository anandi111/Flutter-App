import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:training_app/modals/random_user.dart';
import 'package:training_app/modals/product.dart';
import 'package:training_app/modals/user.dart';
import 'package:training_app/modals/userlist_model.dart';

class APIHelper {
  APIHelper._();

  static final APIHelper apiHelper = APIHelper._();

  Future<List<Product>?> fetchProductData() async {
    http.Response rowData = await http.get(Uri.parse("https://fakestoreapi.com/products/"));

    if (rowData.statusCode == 200) {
      List decodedData = jsonDecode(rowData.body);

      List<Product> productList = [];

      decodedData.map((e) => productList.add(Product.fromMap(map: e))).toList();

      return productList;
    }
    return null;
  }

  Future<List<RandomUser>?> fetchRandomUserData({required int pageId}) async {
    http.Response rowData = await http.get(Uri.parse("https://randomuser.me/api/?page=$pageId&results=10&seed=abc"));

    if (rowData.statusCode == 200) {
      Map decodedData = jsonDecode(rowData.body);

      List decodedList = decodedData["results"];

      List<RandomUser> randomUserList = [];

      decodedList.map((e) => randomUserList.add(RandomUser.formMap(map: e))).toList();

      return randomUserList;
    }
    return null;
  }

  Future<List<User>?> fetchUserData() async {
    http.Response rowData = await http.get(Uri.parse("http://192.168.29.72/Practical_Api/api/get_user_list"), headers: {
      "Token":
          "dyGyy4ST5P8:APA91bFDJ_X9qdRcWvdAnXxnrKXU0DlVUpGf5CQez4mLSn9y6vo0qQUslK2Zj2YLO2eEH-x7K6dyf40Ltd5aCGoNs9Kk2ZRx_oCb88D3l_53SVqjhdKlLKz0enqdtvxDN3K0lg_eISlc"
    });

    if (rowData.statusCode == 200) {
      Map decodedData = jsonDecode(rowData.body);

      List decodedList = decodedData["data"];

      List<User> userList = [];

      decodedList.map((e) => userList.add(User.fromMap(map: e))).toList();

      return userList;
    }
    return null;
  }

  // Future<UserListModel?> fetchUserData() async {
  //   http.Response rowData = await http.get(Uri.parse("http://192.168.29.72/Practical_Api/api/get_user_list"), headers: {
  //     "Token":
  //         "dyGyy4ST5P8:APA91bFDJ_X9qdRcWvdAnXxnrKXU0DlVUpGf5CQez4mLSn9y6vo0qQUslK2Zj2YLO2eEH-x7K6dyf40Ltd5aCGoNs9Kk2ZRx_oCb88D3l_53SVqjhdKlLKz0enqdtvxDN3K0lg_eISlc"
  //   });
  //
  //   if (rowData.statusCode == 200) {
  //     return UserListModel.fromJson(jsonDecode(rowData.body));
  //   } else {
  //     print(rowData.statusCode);
  //     return null;
  //   }
  // }

  Future<User?> fetchSingleUserData({required int id}) async {
    http.Response rowData =
        await http.post(Uri.parse("http://192.168.29.72/Practical_Api/api/get_user_details"), headers: {
      "Token":
          "dyGyy4ST5P8:APA91bFDJ_X9qdRcWvdAnXxnrKXU0DlVUpGf5CQez4mLSn9y6vo0qQUslK2Zj2YLO2eEH-x7K6dyf40Ltd5aCGoNs9Kk2ZRx_oCb88D3l_53SVqjhdKlLKz0enqdtvxDN3K0lg_eISlc"
    }, body: {
      "user_id": id.toString(),
    });

    if (rowData.statusCode == 200) {
      Map decodedData = jsonDecode(rowData.body);

      User user = User.fromMap(map: decodedData["data"]);

      return user;
    }
    return null;
  }

  addUserWithProfilePic({required String name, required String email, required String profilePic}) async {
    var postUri = Uri.parse("http://192.168.29.72/Practical_Api/api/add_user");
    var request = http.MultipartRequest("POST", postUri);
    request.headers.addAll({
      "Token":
          "dyGyy4ST5P8:APA91bFDJ_X9qdRcWvdAnXxnrKXU0DlVUpGf5CQez4mLSn9y6vo0qQUslK2Zj2YLO2eEH-x7K6dyf40Ltd5aCGoNs9Kk2ZRx_oCb88D3l_53SVqjhdKlLKz0enqdtvxDN3K0lg_eISlc"
    });
    print(profilePic);
    request.fields['name'] = name;
    request.fields['email'] = email;
    request.files.add(await http.MultipartFile.fromPath('profile_pic', File(profilePic).path));

    var response = await request.send();

    print(response.statusCode);
  }

  Future<String?> addUserWithOutProfilePic({
    required String name,
    required String email,
    /*required String profilePic*/
  }) async {
    http.Response rowData = await http.post(Uri.parse("http://192.168.29.72/Practical_Api/api/add_user"), headers: {
      "Token":
          "dyGyy4ST5P8:APA91bFDJ_X9qdRcWvdAnXxnrKXU0DlVUpGf5CQez4mLSn9y6vo0qQUslK2Zj2YLO2eEH-x7K6dyf40Ltd5aCGoNs9Kk2ZRx_oCb88D3l_53SVqjhdKlLKz0enqdtvxDN3K0lg_eISlc"
    }, body: {
      "name": name,
      "email": email,
    });

    if (rowData.statusCode == 200) {
      Map decodedData = jsonDecode(rowData.body);

      print(decodedData);

      String msg = decodedData["message"];

      return msg;
    }
    return null;
  }

  Future<String?> deleteUserData({required int id}) async {
    http.Response rowData = await http.delete(Uri.parse("http://192.168.29.72/Practical_Api/api/delete_user"), body: {
      "user_id": id.toString(),
    }, headers: {
      "Token":
          "dyGyy4ST5P8:APA91bFDJ_X9qdRcWvdAnXxnrKXU0DlVUpGf5CQez4mLSn9y6vo0qQUslK2Zj2YLO2eEH-x7K6dyf40Ltd5aCGoNs9Kk2ZRx_oCb88D3l_53SVqjhdKlLKz0enqdtvxDN3K0lg_eISlc"
    });

    if (rowData.statusCode == 200) {
      Map decodedData = jsonDecode(rowData.body);

      String msg = decodedData["message"];

      return msg;
    }

    return null;
  }

  editUserProfilePicData({required String profilePic, required int userId}) async {
    var postUri = Uri.parse("http://192.168.29.72/Practical_Api/api/change_profile_pic");
    var request = http.MultipartRequest("POST", postUri);
    request.headers.addAll({
      "Token":
          "dyGyy4ST5P8:APA91bFDJ_X9qdRcWvdAnXxnrKXU0DlVUpGf5CQez4mLSn9y6vo0qQUslK2Zj2YLO2eEH-x7K6dyf40Ltd5aCGoNs9Kk2ZRx_oCb88D3l_53SVqjhdKlLKz0enqdtvxDN3K0lg_eISlc"
    });
    print(profilePic);
    request.fields['user_id'] = userId.toString();
    request.files.add(await http.MultipartFile.fromPath('profile_pic', File(profilePic).path));

    http.StreamedResponse response = await request.send();
  }

  Future<String?> editUserData({required User user}) async {
    http.Response rowData = await http.put(
      Uri.parse("http://192.168.29.72/Practical_Api/api/edit_user_details"),
      headers: {
        "Token":
            "dyGyy4ST5P8:APA91bFDJ_X9qdRcWvdAnXxnrKXU0DlVUpGf5CQez4mLSn9y6vo0qQUslK2Zj2YLO2eEH-x7K6dyf40Ltd5aCGoNs9Kk2ZRx_oCb88D3l_53SVqjhdKlLKz0enqdtvxDN3K0lg_eISlc"
      },
      body: {
        "user_id": user.userId.toString(),
        "name": user.name,
        "email": user.email,
      },
    );

    if (rowData.statusCode == 200) {
      Map decodedData = jsonDecode(rowData.body);

      String msg = decodedData["message"];

      return msg;
    }
    return null;
  }
}
