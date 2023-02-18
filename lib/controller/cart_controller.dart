import 'package:eat_at_home/controller/data_controller.dart';
import 'package:eat_at_home/controller/sqflite_controller.dart';
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
  SqfLite mydb = SqfLite();

  Future<void> setLoading(int value) async {
    loading = value;
    notifyListeners();
  }

  Future<void> addToCart(CartP product) async {
    // String url = "${Data.apiPath}insert_cart.php";
    // var response = await http.post(
    //   Uri.parse(url),
    //   body: {
    //     "userid": "${product.userId}",
    //     "mealid": "${product.mealId}",
    //     "count": "${product.count}",
    //     "subprice": "${product.subTotalPrice}",
    //   },
    // );

    // int transId = int.parse(response.body);

    // if (transId != 0) {
    //   //print("total price: $totalPrice - count all: $countAll");
    //   product.transId = transId;
    //   cart.add(product);
    //   totalPrice += product.subTotalPrice;
    //   countAll += count;
    //   //print("total price: $totalPrice - count all: $countAll");
    // }
    ////////////////////////////////////
    //SqfLite
    int insert = await mydb.insertData(
      '''
      INSERT INTO cart (user_id, meal_id, count, price, name, sub_price, img, category) 
      VALUES(${product.userId},${product.mealId},${product.count},${product.price},
    '${product.name}',${product.subTotalPrice},'${product.img}','${product.category}');
      ''',
    );
    if (insert != 0) {
      cart.add(product);
      totalPrice += product.subTotalPrice;
      countAll += count;
    }

    // List<Map> responseSqf = await mydb.selectData("select * from cart");
    // print(responseSqf);

    ////////////////////////////////////
    count = 1;
    notifyListeners();
  }

  void deleteFormCart(CartP product) async {
    // String url = "${Data.apiPath}delete_cart.php";

    // var response = await http.post(
    //   Uri.parse(url),
    //   body: {"transid": "${product.transId}"},
    // );

    // if (jsonDecode(response.body) == 1) {
    //  totalPrice -= product.subTotalPrice;
    //   countAll -= product.count;
    //   cart.remove(product);
    //   notifyListeners();
    // }

    //SqfLite
    int delete = await mydb
        .deleteData("delete from cart where tr_id = ${product.transId}");
    if (delete == 1) {
      totalPrice -= product.subTotalPrice;
      countAll -= product.count;
      cart.remove(product);
      notifyListeners();
    }
  }

  Future<void> getCart(int userid) async {
    // String url = "${Data.apiPath}select_cart.php?userid=$userid";

    // var response = await http.get(Uri.parse(url));
    // List responsebody = jsonDecode(response.body);
    //cart.clear();
    // for (var element in responsebody) {
    //   cart.add(
    //     CartP(
    //       transId: element['Transaction_id'],
    //       userId: element['user_fk'],
    //       mealId: element['Meal_id'],
    //       name: element['name'],
    //       price: element['price'].toDouble(),
    //       category: element['category'],
    //       img: element['photo'],
    //       count: element['count'],
    //       subTotalPrice: element['subPrice'].toDouble(),
    //     ),
    //   );
    // }

    //SqfLite
    cart.clear();
    List<Map> select = await mydb.selectData("select * from cart");
    //print(select);
    for (var element in select) {
      cart.add(
        CartP(
          transId: element['tr_id'],
          userId: element['user_id'],
          mealId: element['meal_id'],
          name: element['name'],
          price: element['price'].toDouble(),
          category: element['category'],
          img: element['img'],
          count: element['count'],
          subTotalPrice: element['sub_price'].toDouble(),
        ),
      );
    }
    calculateTotalPrice();
    calculateAllCount();
    notifyListeners();
  }

  Future<void> isExisting(CartP product) async {
    //mydb.deleteData("delete from cart");
    int index = contains(product.name);
    //print("isContained : $index");

    if (index != -1) {
      // String url = "${Data.apiPath}update_count_cart.php";
      // // print("count: ${cart[index].count + product.count}");
      // // print("id: ${cart[index].transId}");
      // // print("subprice: ${cart[index].subTotalPrice + product.subTotalPrice}");
      // var response = await http.post(
      //   Uri.parse(url),
      //   body: {
      //     "count": "${cart[index].count + product.count}",
      //     "id": "${cart[index].transId}",
      //     "subprice": "${cart[index].subTotalPrice + product.subTotalPrice}",
      //   },
      // );
      // if (int.parse(response.body) == 1) {
      //   cart[index].count += count;
      //   countAll += count;
      //   totalPrice += product.subTotalPrice;
      //   count = 1;
      //   notifyListeners();
      // }

      //SqfLite
      int update = await mydb.updateData('''
          UPDATE cart SET count = ${cart[index].count + product.count}, 
          sub_price = ${cart[index].subTotalPrice + product.subTotalPrice} WHERE tr_id = ${cart[index].transId}
          ''');

      if (update == 1) {
        cart[index].count += count;
        countAll += count;
        totalPrice += product.subTotalPrice;
        count = 1;
        notifyListeners();
      }
      //print(await mydb.selectData("select * from cart"));
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
    }

    mydb.deleteData("Delete from cart");
    cart.clear();
    totalPrice = 0;
    countAll = 0;
    notifyListeners();

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
    // String url = "${Data.apiPath}update_count_cart.php";

    // var response = await http.post(
    //   Uri.parse(url),
    //   body: {
    //     "count": "${product.count + 1}",
    //     "id": "${product.transId}",
    //     "subprice": "${product.price * (product.count + 1)}"
    //   },
    // );
    // if (int.parse(response.body) == 1) {
    //   product.count++;
    //   product.subTotalPrice += product.price;
    //   totalPrice += product.price;
    //   countAll++;
    //   notifyListeners();
    // }

    //SqfLite
    int update = await mydb.updateData('''
          UPDATE cart SET count = ${product.count + 1}, 
          sub_price = ${product.price * (product.count + 1)} WHERE tr_id = ${product.transId}
          ''');
    if (update == 1) {
      product.count++;
      product.subTotalPrice += product.price;
      totalPrice += product.price;
      countAll++;
      notifyListeners();
    }
  }

  Future<void> decrementCount(CartP product) async {
    if (product.count > 1) {
      // String url = "${Data.apiPath}update_count_cart.php";
      // var response = await http.post(
      //   Uri.parse(url),
      //   body: {
      //     "count": "${product.count - 1}",
      //     "id": "${product.transId}",
      //     "subprice": "${product.price * (product.count - 1)}"
      //   },
      // );
      // if (int.parse(response.body) == 1) {
      //   product.count--;
      //   countAll--;
      //   product.subTotalPrice -= product.price;
      //   totalPrice -= product.price;
      //   notifyListeners();
      // }

      //SqfLite
      int update = await mydb.updateData('''
          UPDATE cart SET count = ${product.count - 1}, 
          sub_price = ${product.price * (product.count - 1)} WHERE tr_id = ${product.transId}
          ''');
      if (update == 1) {
        product.count--;
        product.subTotalPrice -= product.price;
        totalPrice -= product.price;
        countAll--;
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

  // void logdoutCart() {
  //cart.clear();
  //totalPrice = 0;
  //countAll = 0;
  //notifyListeners();
  // }
}
