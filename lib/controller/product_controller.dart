import 'dart:convert';
import 'package:eat_at_home/controller/data_controller.dart';
import 'package:eat_at_home/model/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class ProductController extends ChangeNotifier {
  List<Product> product = [];
  //String category = "Pizza";
  int x = 0;
  Future<void> getProduct(String category) async {
    product.clear();
    print("Category: $category");
    String url = "${Data.apiPath}select_meal.php?category=$category";

    var response = await http.get(Uri.parse(url));
    var responsebody = jsonDecode(response.body);
    //print(responsebody);
    for (var element in responsebody) {
      product.add(
        Product(
          id: element['Meal_id'],
          name: element['name'],
          price: element['price'].toDouble(),
          category: element['category'],
          photo: element['photo'],
        ),
      );
    }
    notifyListeners();
  }

  Future<void> setCategory(int category) async {
    if (category == 0) {
      await getProduct("Pizza");
      print("Pizza");
    } else if (category == 1) {
      await getProduct("Sandwich");
      print("Sandwisc");
    } else if (category == 2) {
      await getProduct("Salad");
      print("Salad");
    } else if (category == 3) {
      await getProduct("Drinks");
      print("Drinks");
    } else if (category == 4) {
      await getProduct("Other");
      print("Other");
    }
  }
}
