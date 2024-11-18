// ignore_for_file: constant_identifier_names

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../main.dart';

class Data with ChangeNotifier {
  static String apiPath = "http://10.0.2.2/EatAtHome/api/";
  // static String apiPath = "https://mohammadbahlaq.000webhostapp.com/api/";
  static String imgPath = "http://10.0.2.2/EatAtHome/images/";
  // static String imgPath = "https://mohammadbahlaq.000webhostapp.com/images/";

  Future<String> httpTest(
    HttpMethod httpMethod,
    EndPotin endPotin,
    dynamic body, {
    Map<String, String> header = const {},
    Map<String, String> parameters = const {},
  }) async {
    Uri url = Uri.parse("$apiPath/$endPotin");
    url = url.replace(queryParameters: parameters);

    header.addAll({"your static heade": "any thig"});

    http.Response response;

    switch (httpMethod) {
      case HttpMethod.GET:
        response = await http.get(url, headers: header);
        break;
      case HttpMethod.POST:
        response = await http.post(url, headers: header, body: jsonEncode(body));
        break;
      case HttpMethod.PUT:
        response = await http.put(url, headers: header, body: jsonEncode(body));
        break;
      case HttpMethod.PATCH:
        response = await http.patch(url, headers: header, body: jsonEncode(body));
        break;
      case HttpMethod.DELETE:
        response = await http.delete(url, headers: header, body: jsonEncode(body));

        break;
    }

    switch (response.statusCode) {
      case 200:
        return response.body;
      case 400:
        throw ("Bad Request");
      case 402 || 403:
        throw ("Please try again");
      case 404:
        throw ("Not Found");
      default:
        return throw ("Another Error don't known");
    }
  }

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
    prefs.setString("email", email);
    prefs.setString("password", password);
    prefs.setInt("id", id);
  }
}

enum HttpMethod {
  GET,
  POST,
  PUT,
  PATCH,
  DELETE,
}

enum EndPotin {
  APiName,
}
