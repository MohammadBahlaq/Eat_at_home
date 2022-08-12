// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:e_commerce/controller/data.dart';
import 'package:e_commerce/model/Cart.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class CartController with ChangeNotifier {
  List<CartP> cart = [];
  double totalPrice = 0;
  int count = 1;

  Future<void> addToCart(CartP product) async {
    totalPrice += product.subTotalPrice;
    String url = "${Data.apiPath}insert_cart.php";
    var response = await http.post(
      Uri.parse(url),
      body: {
        "userid": "${product.userId}",
        "mealid": "${product.mealId}",
        "count": "${product.count}",
        "subprice": "${product.subTotalPrice}",
      },
    );
    print(jsonDecode(response.body));

    //////////////////////////////////////
    count = 1;
    notifyListeners();
  }

  void deleteFormCart(CartP product) async {
    totalPrice -= product.subTotalPrice;
    String url = "${Data.apiPath}delete_cart.php";

    var response = await http.post(
      Uri.parse(url),
      body: {"transid": "${product.transId}"},
    );

    if (jsonDecode(response.body) == 1) {
      cart.remove(product);
      notifyListeners();
    }
  }

  Future<void> getCart(int userid) async {
    cart.clear();
    String url = "${Data.apiPath}select_cart.php?userid=$userid";

    var response = await http.get(Uri.parse(url));
    List responsebody = jsonDecode(response.body);
    for (var element in responsebody) {
      cart.add(
        CartP(
          transId: element['Transaction_id'],
          userId: element['user_fk'],
          mealId: element['Meal_id'],
          name: element['name'],
          price: element['price'],
          category: element['category'],
          img: element['photo'],
          count: element['count'],
          subTotalPrice: element['subPrice'],
        ),
      );
    }
    calculateTotalPrice();
    notifyListeners();
  }

  void calculateTotalPrice() {
    totalPrice = 0;
    for (var element in cart) {
      totalPrice += element.subTotalPrice;
    }
    notifyListeners();
  }

  void incrementCount(CartP product) {
    product.count++;
    product.subTotalPrice += product.price;
    totalPrice += product.price;
    notifyListeners();
  }

  void decrementCount(CartP product) {
    if (product.count > 1) {
      product.count--;
      product.subTotalPrice -= product.price;
      totalPrice -= product.price;
      notifyListeners();
    }
  }

  void increment() {
    count++;
    notifyListeners();
  }

  void decrement() {
    if (count > 1) {
      count--;
      notifyListeners();
    }
  }

  void logoutCart() {
    cart.clear();
    totalPrice = 0;
    notifyListeners();
  }
}
