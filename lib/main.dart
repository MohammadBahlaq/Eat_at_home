import 'package:eat_at_home/controller/bill_controller.dart';
import 'package:eat_at_home/controller/cart_controller.dart';
import 'package:eat_at_home/controller/user_controller.dart';
import 'package:eat_at_home/view/bill_page.dart';
import 'package:eat_at_home/view/cart_page.dart';
import 'package:eat_at_home/view/home_page.dart';
import 'package:eat_at_home/view/login_page.dart';
import 'package:eat_at_home/view/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartController()),
        ChangeNotifierProvider(create: (context) => UserController()),
        ChangeNotifierProvider(create: (context) => BillController())
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          primaryColor: Colors.deepPurpleAccent,
          inputDecorationTheme: const InputDecorationTheme(),
          listTileTheme: ListTileThemeData(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        home: const Home(),
        routes: {
          "cart": (context) => const Cart(),
          "signup": (context) => Signup(),
          "login": (context) => Login(),
          "home": (context) => const Home(),
          "bill": (context) => const Bill(),
        },
      ),
    );
  }
}
