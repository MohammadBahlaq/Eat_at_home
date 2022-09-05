import 'package:eat_at_home/controller/data.dart';
import 'package:eat_at_home/model/bill.dart';
import 'package:eat_at_home/widgets/cart_card.dart';
import 'package:eat_at_home/widgets/custom_dialog.dart';
import 'package:eat_at_home/widgets/login_signup_btn.dart';
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
        return ListView.builder(
          padding: EdgeInsets.only(bottom: mq.size.height * 0.07),
          itemCount: cartController.cart.length,
          itemBuilder: (BuildContext context, i) {
            return CartCard(
              image: "${Data.imgPath}${cartController.cart[i].img}",
              category: cartController.cart[i].category,
              name: cartController.cart[i].name,
              index: i,
              onClick: () {
                cartController.deleteFormCart(cartController.cart[i]);
                print(i);
              },
              onIncrement: () {
                cartController.incrementCount(cartController.cart[i]);
              },
              onDecrement: () {
                cartController.decrementCount(cartController.cart[i]);
              },
            );
          },
        );
      },
    );
  }
}
