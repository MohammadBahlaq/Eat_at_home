import 'dart:convert';
import 'package:eat_at_home/controller/data.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class BillController with ChangeNotifier {
  List bills = [];

  Future<void> getBill(int userid) async {
    bills.clear();
    String url = "${Data.apiPath}select_user_bill.php?userid=$userid";

    var response = await http.get(Uri.parse(url));
    var responsebody = jsonDecode(response.body);
    bills.addAll(responsebody);
    print(bills.length);
    notifyListeners();
  }
}
