// ignore_for_file: avoid_print

import 'package:eat_at_home/controller/bill_controller.dart';
import 'package:eat_at_home/controller/user_controller.dart';
import 'package:eat_at_home/model/bill.dart';
import 'package:eat_at_home/widgets/cart_body.dart';
import 'package:eat_at_home/widgets/custom_dialog.dart';
import 'package:eat_at_home/widgets/login_signup_btn.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/cart_controller.dart';

class Cart extends StatelessWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CartController cartController = context.read<CartController>();
    final UserController userController = context.read<UserController>();
    final billController = context.read<BillController>();
    final mq = MediaQuery.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Cart"), centerTitle: true),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Selector<CartController, int>(
            selector: (p0, p1) => p1.loading,
            builder: (context, loading, child) {
              if (loading == 0) {
                return const Center(child: CircularProgressIndicator());
              } else if (loading == 1) {
                return cartController.cart.isEmpty
                    ? const Center(
                        child: Text("You don't have any item",
                            style: TextStyle(fontSize: 18)))
                    : const CartBuilder();
              } else {
                return const CartBuilder();
              }
            },
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: CustomButton(
              text: Selector<CartController, double>(
                selector: (context, p1) => p1.totalPrice,
                builder: (context, totalPrice, child) {
                  return Text(
                    "Confirm your order (${totalPrice.toStringAsFixed(2)} JD)",
                    style: const TextStyle(fontSize: 18),
                  );
                },
              ),
              onClick: () async {
                DateTime date = DateTime.now();
                if (userController.isLogin) {
                  if (cartController.cart.isNotEmpty) {
                    loadingDialog(context);
                    await cartController.confirm(
                              BillP(
                                date: "${date.day}/${date.month}/${date.year}",
                                time:
                                    "${date.hour.toString().padLeft(2, "0")}:${date.minute.toString().padLeft(2, "0")}",
                                status: 1,
                                totalprice: cartController.totalPrice,
                              ),
                              cartController.cart,
                            ) ==
                            1
                        // 0 == 1
                        ? showAlertDialog(
                            context, billController, userController)
                        : showSnackBar(context, mq);
                  }
                } else {
                  Navigator.of(context).pushNamed("login");
                }
              },
              //padding: 0,
              //borderRadius: 0,
            ),
          ),
        ],
      ),
    );
  }

  void showSnackBar(BuildContext context, MediaQueryData mq) {
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.redAccent,
        content: Row(
          children: [
            const Icon(
              Icons.error,
              size: 25,
              color: Colors.white,
            ),
            SizedBox(width: mq.size.width / 20),
            const Text(
              "There is an error please try later",
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  void showAlertDialog(BuildContext context, BillController billController,
      UserController userController) {
    Navigator.of(context).pop();
    showDialog(
      context: context,
      builder: (context) {
        return CustomDialog(
          title: "Done",
          msg: "Your order confirmed click OK to tracing your order",
          onClick: () async {
            Navigator.of(context).pushReplacementNamed("bill");
            billController.setLoading(0);
            await billController.getBill(userController.userInfo!.id);
            print(billController.bills.length);
            billController.setLoading(1);
          },
        );
      },
    );
  }

  void loadingDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Loading...", style: TextStyle(fontSize: 18)),
              SizedBox(height: MediaQuery.of(context).size.height / 25),
              const CircularProgressIndicator(),
            ],
          ),
        );
      },
    );
  }
}
