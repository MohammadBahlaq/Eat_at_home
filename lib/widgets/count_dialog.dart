import 'package:eat_at_home/controller/cart_controller.dart';
import 'package:eat_at_home/widgets/inc_dec_buttons.dart';
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
    final mq = MediaQuery.of(context);
    return AlertDialog(
      title: const Text("Count"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IncDecButton(
                icon: const Icon(Icons.add, color: Colors.green),
                color: Colors.transparent,
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
              IncDecButton(
                icon: const Icon(Icons.remove, color: Colors.red),
                color: Colors.transparent,
                onClick: onDecrement,
              ),
            ],
          ),
          SizedBox(height: mq.size.height / 36),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              //backgroundColor: Colors.blue,
              fixedSize: Size(
                mq.size.width / 2,
                mq.size.height / 15,
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
