// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:eat_at_home/controller/data.dart';
import 'package:eat_at_home/model/Cart.dart';
import 'package:eat_at_home/model/bill.dart';
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
    ////////////////////////////////////
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

  Future<int> confirm(BillP bill, List<CartP> products) async {
    String url = "${Data.apiPath}create_bill.php";
    var response = await http.post(Uri.parse(url), body: {
      "date": bill.date,
      "time": bill.time,
      "status": "${bill.status}",
      "totalprice": "${bill.totalprice}",
      "userid": "${products[0].userId}",
    });

    int billID = int.parse(response.body);
    print("Bill id: $billID");
    url = "${Data.apiPath}confirme.php";
    for (CartP product in products) {
      response = await http.post(
        Uri.parse(url),
        body: {
          "userid": "${product.userId}",
          "mealid": "${product.mealId}",
          "count": "${product.count}",
          "subprice": "${product.subTotalPrice}",
          "billid": "$billID"
        },
      );
      print("Meal id: ${product.mealId}");
    }
    print(int.parse(response.body));
    return int.parse(response.body);
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
