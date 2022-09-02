// ignore_for_file: avoid_print

import 'package:eat_at_home/controller/cart_controller.dart';
import 'package:eat_at_home/widgets/inc_dec_buttons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartCard extends StatelessWidget {
  const CartCard({
    Key? key,
    required this.image,
    required this.category,
    required this.name,
    required this.index,
    required this.onClick,
    required this.onIncrement,
    required this.onDecrement,
  }) : super(key: key);

  final String image;
  final String category;
  final String name;
  final int index;
  final void Function() onClick;
  final void Function() onIncrement;
  final void Function() onDecrement;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    return Container(
      margin: EdgeInsets.only(bottom: mq.size.height / 50),
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.network(
            image,
            height: mq.size.height / 5.5,
            width: mq.size.width / 2.5,
            fit: category == "Beverages" ? BoxFit.contain : BoxFit.fill,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: mq.size.width / 3,
                child: Text(
                  name,
                  style: const TextStyle(fontSize: 18),
                  softWrap: true,
                ),
              ),
              SizedBox(height: mq.size.height / 50),
              Selector<CartController, double>(
                selector: (context, p1) {
                  return p1.cart[index].subTotalPrice;
                },
                builder: (context, value, child) {
                  //print("rebuild selector line $index");
                  return Text(
                    "${value.toStringAsFixed(2)} JD",
                    style: const TextStyle(fontSize: 18),
                  );
                },
              ),
              // Text(
              //   "${context.select<CartController, double>((p1) {
              //     print("index = $index");
              //     return p1.cart[index].subTotalPrice;
              //   })} JD",
              //   style: const TextStyle(fontSize: 18),
              // ),
              Row(
                children: [
                  CustonButton(
                    icon: const Icon(Icons.add),
                    color: Colors.green,
                    onClick: onIncrement,
                  ),
                  Selector<CartController, int>(
                    selector: (context, p1) {
                      return p1.cart[index].count;
                    },
                    builder: (context, value, child) {
                      return Text(
                        "$value",
                        style: const TextStyle(fontSize: 18),
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                      );
                    },
                  ),
                  CustonButton(
                    icon: const Icon(Icons.remove),
                    color: Colors.red,
                    onClick: onDecrement,
                  ),
                ],
              ),
            ],
          ),
          CustonButton(
            icon: const Icon(Icons.remove),
            padding: 0,
            onClick: onClick,
          ),
        ],
      ),
    );
  }
}
