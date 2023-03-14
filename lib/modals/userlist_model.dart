class UserListModel {
  bool? status;
  int? statusCode;
  String? message;
  List<Data>? data;

  UserListModel({this.status, this.statusCode, this.message, this.data});

  UserListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['statusCode'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['statusCode'] = this.statusCode;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? userId;
  String? name;
  String? email;
  String? profilePic;
  int? badgeCount;
  String? createdAt;

  Data({this.userId, this.name, this.email, this.profilePic, this.badgeCount, this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    name = json['name'];
    email = json['email'];
    profilePic = json['profile_pic'];
    badgeCount = json['badge_count'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['profile_pic'] = this.profilePic;
    data['badge_count'] = this.badgeCount;
    data['created_at'] = this.createdAt;
    return data;
  }
}
