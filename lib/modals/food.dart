class Food {
  String foodname;
  String foodPhoto;
  num price;
  num rating;
  bool? isTopRated;
  bool? isFrequentlyOrdered;
  bool? isPro;
  int? offerPersentage;

  Food({
    required this.foodname,
    required this.foodPhoto,
    required this.price,
    required this.rating,
    this.isTopRated,
    this.isFrequentlyOrdered,
    this.isPro,
    this.offerPersentage,
  });
}
