import 'dart:convert';
import 'package:eat_at_home/controller/data_controller.dart';
import 'package:eat_at_home/model/bill.dart';
import 'package:eat_at_home/model/meal.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class BillController with ChangeNotifier {
  List<BillP> bills = [];
  List meals = [];
  int loading = 0;

  Future<void> setLoading(int value) async {
    loading = value;
    notifyListeners();
  }

  Future<void> getBill(int userid) async {
    bills.clear();
    String url = "${Data.apiPath}select_user_bill.php?userid=$userid";

    var response = await http.get(Uri.parse(url));
    var responsebody = jsonDecode(response.body);

    for (var element in responsebody) {
      bills.add(
        BillP(
          id: element['id'],
          date: element['Date'],
          time: element['Time'],
          status: element['Status'],
          totalprice: element['total_price'].toDouble(),
          userid: element['user_id'],
          name: element['name'],
        ),
      );
    }
    notifyListeners();
  }

  Future<void> getItems(int billID) async {
    meals.clear();
    String url = "${Data.apiPath}select_items_bill.php?billid=$billID";

    var response = await http.get(Uri.parse(url));
    var responsebody = jsonDecode(response.body);

    for (var meal in responsebody) {
      meals.add(
        Meal(
          name: meal['name'],
          category: meal['category'],
          image: meal['photo'],
          count: meal['count'],
          subPrice: meal['sub_price'].toDouble(),
        ),
      );
    }
    notifyListeners();
  }
}
