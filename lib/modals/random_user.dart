class RandomUser {
  String photo;
  String name;
  String email;

  RandomUser({
    required this.photo,
    required this.name,
    required this.email,
  });

  factory RandomUser.formMap({required Map map}) {
    return RandomUser(
        photo: map["picture"]["large"],
        name: map["name"]["first"] + " " + map["name"]["last"],
        email: map["email"]);
  }
}
