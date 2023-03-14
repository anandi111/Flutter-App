class Product {
  int id;
  String title = "";
  String description = "";
  num price = 0;
  String image = "";

  Product(
      {required this.id,
      required this.title,
      required this.description,
      required this.price,
      required this.image});

  factory Product.fromMap({required Map map}) {
    return Product(
        id: map["id"],
        title: map["title"],
        description: map["description"],
        price: map["price"],
        image: map["image"]);
  }
}
