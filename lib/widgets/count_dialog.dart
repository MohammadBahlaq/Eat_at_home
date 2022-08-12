import 'package:e_commerce/controller/cart_controller.dart';
import 'package:e_commerce/widgets/inc_dec_buttons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CountDialog extends StatelessWidget {
  const CountDialog({
    Key? key,
    this.incColor = Colors.black,
    this.decColor = Colors.black,
    required this.onIncrement,
    required this.onDecrement,
    required this.onConfirm,
  }) : super(key: key);

  final Color incColor;
  final Color decColor;
  final void Function() onIncrement;
  final void Function() onDecrement;
  final void Function() onConfirm;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Count"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustonButton(
                icon: const Icon(Icons.add),
                onClick: onIncrement,
              ),
              Selector<CartController, int>(
                selector: (context, p1) {
                  return p1.count;
                },
                builder: (context, count, child) {
                  return Text(
                    "$count",
                    style: const TextStyle(fontSize: 18),
                  );
                },
              ),
              CustonButton(
                icon: const Icon(Icons.remove),
                onClick: onDecrement,
              ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height / 36),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.black,
              fixedSize: Size(
                MediaQuery.of(context).size.width / 2,
                MediaQuery.of(context).size.height / 15,
              ),
            ),
            onPressed: onConfirm,
            child: const Text("Add", style: TextStyle(fontSize: 18)),
          ),
        ],
      ),
    );
  }
}