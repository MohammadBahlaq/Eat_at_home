// ignore_for_file: file_names

class CartP {
  int transId;
  int userId;
  int mealId;
  String name;
  double price;
  double subTotalPrice = 0;
  String img;
  int count;
  String category;

  CartP({
    this.transId = 0,
    required this.userId,
    required this.mealId,
    required this.name,
    required this.count,
    required this.price,
    required this.subTotalPrice,
    required this.category,
    required this.img,
  });
}
