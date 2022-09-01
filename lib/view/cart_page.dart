// ignore_for_file: avoid_print

import 'package:eat_at_home/controller/data.dart';
import 'package:eat_at_home/widgets/cart_card.dart';
import 'package:eat_at_home/widgets/login_signup_btn.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/cart_controller.dart';

class Cart extends StatelessWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Cart")),
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
                              "${Data.imgPath}${context.read<CartController>().cart[i].img}",
                          category:
                              context.read<CartController>().cart[i].category,
                          name: context.read<CartController>().cart[i].name,
                          index: i,
                          onClick: () {
                            context.read<CartController>().deleteFormCart(
                                context.read<CartController>().cart[i]);
                          },
                          onIncrement: () {
                            context.read<CartController>().incrementCount(
                                context.read<CartController>().cart[i]);
                          },
                          onDecrement: () {
                            context.read<CartController>().decrementCount(
                                context.read<CartController>().cart[i]);
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
              onClick: () {},
              padding: 0,
              borderRadius: 0,
            ),
          ),
        ],
      ),
    );
  }
}
