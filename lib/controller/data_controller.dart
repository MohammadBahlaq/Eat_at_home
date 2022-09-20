import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../main.dart';

class Data with ChangeNotifier {
  static String apiPath =
      "http://10.0.2.2/EatAtHome/api/"; //https://mohammadbahlaq.000webhostapp.com/api/
  static String imgPath =
      "http://10.0.2.2/EatAtHome/images/"; //https://mohammadbahlaq.000webhostapp.com/images/

  bool isVisiable = true;
  bool remember = false;

  void visibility() {
    isVisiable = !isVisiable;
    notifyListeners();
  }

  void setRemember() {
    remember = !remember;
    notifyListeners();
  }

  void checkRemember(String email, String password, int id) async {
    prefs!.setString("email", email);
    prefs!.setString("password", password);
    prefs!.setInt("id", id);
  }
}
