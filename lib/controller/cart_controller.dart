import 'dart:convert';
import 'package:eat_at_home/controller/data_controller.dart';
import 'package:eat_at_home/model/Cart.dart';
import 'package:eat_at_home/model/bill.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CartController with ChangeNotifier {
  List<CartP> cart = [];
  double totalPrice = 0;
  int count = 1;
  int countAll = 0;
  int loading = 0;

  Future<void> setLoading(int value) async {
    loading = value;
    notifyListeners();
  }

  Future<void> addToCart(CartP product) async {
    totalPrice += product.subTotalPrice;
    countAll += count;
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

    if (jsonDecode(response.body) == 1) {
      cart.add(product);
    }
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
      countAll -= product.count;
      cart.remove(product);
      notifyListeners();
    }
  }

  Future<void> getCart(int userid) async {
    String url = "${Data.apiPath}select_cart.php?userid=$userid";

    var response = await http.get(Uri.parse(url));
    List responsebody = jsonDecode(response.body);
    cart.clear();
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
          subTotalPrice: element['subPrice'].toDouble(),
        ),
      );
    }

    calculateTotalPrice();
    calculateAllCount();
    notifyListeners();
  }

  Future<void> isExisting(CartP product) async {
    int index = contains(product.name);

    if (index != -1) {
      String url = "${Data.apiPath}update_count_cart.php";

      var response = await http.post(
        Uri.parse(url),
        body: {
          "count": "${cart[index].count + product.count}",
          "id": "${cart[index].transId}",
          "subprice": "${cart[index].subTotalPrice + product.subTotalPrice}",
        },
      );
      if (int.parse(response.body) == 1) {
        cart[index].count += count;
        countAll += count;
        totalPrice += product.subTotalPrice;
        count = 1;
        notifyListeners();
      }
    } else {
      await addToCart(product);
    }
  }

  int contains(String mealName) {
    for (int index = 0; index < cart.length; index++) {
      if (mealName == cart[index].name) {
        return index;
      }
    }
    return -1;
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

  void calculateAllCount() {
    countAll = 0;
    for (var element in cart) {
      countAll += element.count;
    }
  }

  Future<void> incrementCount(CartP product) async {
    String url = "${Data.apiPath}update_count_cart.php";

    var response = await http.post(
      Uri.parse(url),
      body: {
        "count": "${product.count + 1}",
        "id": "${product.transId}",
        "subprice": "${product.price * (product.count + 1)}"
      },
    );
    if (int.parse(response.body) == 1) {
      product.count++;
      product.subTotalPrice += product.price;
      totalPrice += product.price;
      countAll++;
      notifyListeners();
    }
  }

  Future<void> decrementCount(CartP product) async {
    if (product.count > 1) {
      String url = "${Data.apiPath}update_count_cart.php";
      var response = await http.post(
        Uri.parse(url),
        body: {
          "count": "${product.count - 1}",
          "id": "${product.transId}",
          "subprice": "${product.price * (product.count - 1)}"
        },
      );
      if (int.parse(response.body) == 1) {
        product.count--;
        countAll--;
        product.subTotalPrice -= product.price;
        totalPrice -= product.price;
        notifyListeners();
      }
    } else {
      deleteFormCart(product);
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
    countAll = 0;
    notifyListeners();
  }
}
