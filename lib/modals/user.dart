class User {
  int userId;
  String name;
  String email;
  String profilePic;
  String createDate;
  bool? isAdd;

  User(
      {required this.userId,
      required this.name,
      required this.email,
      required this.profilePic,
      required this.createDate,
      this.isAdd});

  factory User.fromMap({required Map map}) {
    return User(
        userId: map["user_id"],
        name: map["name"],
        email: map["email"],
        profilePic: map["profile_pic"],
        createDate: map["created_at"]);
  }
}
