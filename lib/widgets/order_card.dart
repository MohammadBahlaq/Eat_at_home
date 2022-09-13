import 'package:flutter/material.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({
    super.key,
    required this.index,
    required this.orderId,
    required this.totalPrice,
    required this.date,
    required this.time,
    required this.status,
    required this.mobile,
    required this.onCadrClick,
  });

  final int index;
  final int orderId;
  final double totalPrice;
  final String date;
  final String time;
  final int status;
  final String mobile;
  final void Function() onCadrClick;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    return InkWell(
      onTap: onCadrClick,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: mq.size.height * 0.01,
          horizontal: mq.size.width * 0.032,
        ),
        margin: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              color: Colors.black,
              blurRadius: 5,
            ),
          ],
          color: status == 1 ? Colors.white : Colors.grey,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Order ID: $orderId",
                  style: const TextStyle(
                      fontSize: 23, fontWeight: FontWeight.bold),
                ),
                Text(
                  "${totalPrice.toStringAsFixed(2)} JD",
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: mq.size.height * 0.03),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Date: $date - $time",
                  style: const TextStyle(fontSize: 16),
                ),
                SizedBox(
                  width: mq.size.width * 0.31,
                  child: Text(
                    status == 1 ? "In progrecess" : "Done",
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
