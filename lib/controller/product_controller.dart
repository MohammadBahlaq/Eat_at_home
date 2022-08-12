// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:e_commerce/controller/data.dart';
import 'package:e_commerce/model/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class ProductController extends ChangeNotifier {
  List<Product> product = [];

  // List<Product> data = [
  //   Product("Pizza", "Margarita Pizza", 3.75, "Margarita2_big.jpg"),
  //   Product("Pizza", "Chicken Alfredo Pizza", 5.99, "Chicken Alfredo2_big.jpg"),
  //   Product(
  //       "Pizza", "Pepperoni Lovers Pizza", 4.74, "Pepperoni lovers2_big.jpg"),
  //   ////////////////////////////
  //   Product("Sandwich", "Philly Steak Sandwich", 2.54,
  //       "Philly steak sandwich2_big.jpg"),
  //   Product("Sandwich", "Chicken Sandwich", 2.37, "Chicken sandwich2_big.jpg"),
  //   Product("Sandwich", "Hotdog Sandwich", 2.15, "turkey sandwich2_big.jpg"),
  //   Product("Sandwich", "Turkey Sandwich", 2.37, "hotdog sandwich2_big.jpg"),
  //   ////////////////////////////
  //   Product("Salad", "Caesar Salad", 3.01, "Caesar salad2_big.jpg"),
  //   Product("Salad", "Greek Salad", 2.37, "Greek salad2_big.jpg"),
  //   Product("Salad", "Arabic Salad", 1.94, "Arabic salad2_big.jpg"),
  //   Product("Salad", "Tuna Salad", 2.59, "Tuna salad2_big.jpg"),
  //   ////////////////////////////
  //   Product("Beverages", "Pepsi", 0.52, "Pepsi-min_636021950800177962.jpg"),
  //   Product("Beverages", "Diet Pepsi", 0.52, "Diet_Pepsi_big.jpg"),
  //   Product("Beverages", "Mountain Dew", 0.52, "mtnDew_big.jpg"),
  //   Product("Beverages", "Mineral Water (Small)", 0.26,
  //       "Water-min_636021951390013962.jpg"),
  //   ////////////////////////////
  //   Product("Extra", "Boneless Wings", 3.02, "bonless wing_big.jpg"),
  //   Product("Extra", "French Fries", 0.86, "french fries2_big.jpg"),
  //   Product("Extra", "Potato Wedges", 1.29, "wedges2_big.jpg"),
  // ];

  Future<void> getProduct(String category) async {
    product.clear();
    String url = "${Data.apiPath}select_meal.php?category=$category";

    var response = await http.get(Uri.parse(url));
    var responsebody = jsonDecode(response.body);
    //print(responsebody);
    for (var element in responsebody) {
      product.add(
        Product(
          id: element['Meal_id'],
          name: element['name'],
          price: element['price'],
          category: element['category'],
          photo: element['photo'],
        ),
      );
      //print(product);
    }
    notifyListeners();
    // for (Product element in data) {
    //   if (element.category == category) product.add(element);
    // }
  }
}
