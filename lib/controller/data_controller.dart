import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../main.dart';

class Data with ChangeNotifier {
  static String apiPath =
      "https://mohammadbahlaq.000webhostapp.com/api/"; //http://10.0.2.2/EatAtHome/api/
  static String imgPath =
      "https://mohammadbahlaq.000webhostapp.com/images/"; //http://10.0.2.2/EatAtHome/images/

  bool isVisiable = true;
  bool isVisiableSignup = true;
  bool remember = false;

  void visibility() {
    isVisiable = !isVisiable;
    notifyListeners();
  }

  void visibilityS() {
    isVisiableSignup = !isVisiableSignup;
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
