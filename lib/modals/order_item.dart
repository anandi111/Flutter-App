class OrderItem {
  String foodName;
  String foodPic;
  String orderTime;
  int offPersentage;
  bool? isLabel;

  OrderItem({
    required this.foodName,
    required this.foodPic,
    required this.orderTime,
    required this.offPersentage,
    this.isLabel,
  });
}
