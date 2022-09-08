// ignore_for_file: avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Data with ChangeNotifier {
  static String apiPath =
      "http://10.0.2.2/EatAtHome/api/"; //https://mohammadbahlaq.000webhostapp.com/api/
  static String imgPath =
      "http://10.0.2.2/EatAtHome/images/"; //https://mohammadbahlaq.000webhostapp.com/images/

  bool isVisiable = true;

  void visibility() {
    isVisiable = !isVisiable;
    notifyListeners();
  }
}
