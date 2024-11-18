// ignore_for_file: deprecated_member_use

import 'package:eat_at_home/controller/bill_controller.dart';
import 'package:eat_at_home/controller/cart_controller.dart';
import 'package:eat_at_home/controller/product_controller.dart';
import 'package:eat_at_home/controller/user_controller.dart';
import 'package:eat_at_home/view/bill_detailes_page.dart';
import 'package:eat_at_home/view/bill_page.dart';
import 'package:eat_at_home/view/cart_page.dart';
import 'package:eat_at_home/view/home_page.dart';
import 'package:eat_at_home/view/login_page.dart';
import 'package:eat_at_home/view/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? prefs;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartController()),
        ChangeNotifierProvider(create: (context) => UserController()),
        ChangeNotifierProvider(create: (context) => BillController()),
        ChangeNotifierProvider(create: (context) => ProductController()),
      ],
      builder: (context, child) {
        final UserController userCrt = context.read<UserController>();
        final CartController cartCrt = context.read<CartController>();
        final ProductController productCrt = context.read<ProductController>();
        productCrt.getProduct("Pizza");

        if (prefs!.getString("email") != null) {
          userCrt.login(prefs!.getString("email")!, prefs!.getString("password")!);
          cartCrt.getCart(prefs!.getInt("id")!);
        }
        return const MyApp();
      },
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: false,
        primarySwatch: Colors.blue,
        primaryColor: Colors.blueAccent,
        inputDecorationTheme: const InputDecorationTheme(),
      ),
      home: const Home(),
      routes: {
        "cart": (context) => const Cart(),
        "signup": (context) => const Signup(),
        "login": (context) => const Login(),
        "home": (context) => const Home(),
        "bill": (context) => const Bill(),
        "detailes": (context) => const BillDetailes(),
      },
    );
  }
}
