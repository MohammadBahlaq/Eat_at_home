import 'package:eat_at_home/controller/data_controller.dart';
import 'package:eat_at_home/widgets/cart_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/cart_controller.dart';

class CartBuilder extends StatelessWidget {
  const CartBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    final CartController cartController = context.read<CartController>();
    final mq = MediaQuery.of(context);

    return Selector<CartController, int>(
      selector: (p0, p1) => p1.cart.length,
      builder: (context, value, child) {
        return value == 0
            ? const Center(
                child: Text("You don't have any item",
                    style: TextStyle(fontSize: 18)))
            : ListView.builder(
                padding: EdgeInsets.only(
                  bottom: mq.size.height * 0.07,
                  top: mq.size.height * 0.014,
                ),
                itemCount: cartController.cart.length,
                itemBuilder: (BuildContext context, i) {
                  return CartCard(
                    image: "${Data.imgPath}${cartController.cart[i].img}",
                    category: cartController.cart[i].category,
                    name: cartController.cart[i].name,
                    index: i,
                    onIncrement: () async {
                      await cartController
                          .incrementCount(cartController.cart[i]);
                    },
                    onDecrement: () async {
                      await cartController
                          .decrementCount(cartController.cart[i]);
                    },
                  );
                },
              );
      },
    );
  }
}
