// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:eat_at_home/controller/data_controller.dart';
import 'package:eat_at_home/model/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class ProductController extends ChangeNotifier {
  List<Product> product = [];

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
