// ignore_for_file: avoid_print

import 'package:eat_at_home/controller/bill_controller.dart';
import 'package:eat_at_home/controller/data.dart';
import 'package:eat_at_home/controller/user_controller.dart';
import 'package:eat_at_home/widgets/cart_card.dart';
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
    final mq = MediaQuery.of(context);
    return ChangeNotifierProvider(
      create: (context) => BillController(),
      builder: (context, child) {
        final BillController billController = context.read<BillController>();
        return Scaffold(
          appBar: AppBar(title: const Text("Cart"), centerTitle: true),
          body: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Selector<CartController, int>(
                selector: (context, p1) => p1.cart.length,
                builder: (context, cartlength, child) {
                  return cartlength == 0
                      ? const Center(child: CircularProgressIndicator())
                      : ListView.builder(
                          padding: const EdgeInsets.only(bottom: 45),
                          itemCount: cartlength,
                          itemBuilder: (BuildContext context, i) {
                            return CartCard(
                              image:
                                  "${Data.imgPath}${cartController.cart[i].img}",
                              category: cartController.cart[i].category,
                              name: cartController.cart[i].name,
                              index: i,
                              onClick: () {
                                cartController
                                    .deleteFormCart(cartController.cart[i]);
                              },
                              onIncrement: () {
                                cartController
                                    .incrementCount(cartController.cart[i]);
                              },
                              onDecrement: () {
                                cartController
                                    .decrementCount(cartController.cart[i]);
                              },
                            );
                          },
                        );
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

                    //print("${date.day}/${date.month}/${date.year}");
                    //print("${date.hour.toString().padLeft(2, "0")}:${date.minute.toString().padLeft(2, "0")}");

                    // await cartController.confirm(
                    //           Bill(
                    //             date: "${date.day}/${date.month}/${date.year}",
                    //             time:
                    //                 "${date.hour.toString().padLeft(2, "0")}:${date.minute.toString().padLeft(2, "0")}",
                    //             status: 1,
                    //             totalprice: cartController.totalPrice,
                    //           ),
                    //           cartController.cart,
                    //         )
                    1 == 1
                        ? showDialog(
                            context: context,
                            builder: (context) {
                              return CustomDialog(
                                title: "Done",
                                msg:
                                    "Your order confirmed click OK to tracing your order",
                                onClick: () async {
                                  await billController
                                      .getBill(userController.userInfo!.id);
                                  Navigator.of(context)
                                      .pushReplacementNamed("bill");
                                },
                              );
                            },
                          )
                        : ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              duration: const Duration(seconds: 3),
                              backgroundColor: Colors.blueAccent,
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
                  },
                  padding: 0,
                  borderRadius: 0,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
