import 'package:flutter/material.dart';

class BillCard extends StatelessWidget {
  const BillCard({
    super.key,
    required this.id,
    required this.onClick,
    required this.date,
    required this.time,
    required this.totalprice,
    required this.status,
  });

  final int id;
  final void Function() onClick;
  final String date;
  final String time;
  final double totalprice;
  final String status;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: mq.size.height * 0.027,
        horizontal: mq.size.width * 0.06,
      ),
      margin: EdgeInsets.symmetric(
        vertical: mq.size.height * 0.013,
        horizontal: mq.size.width * 0.03,
      ),
      height: mq.size.height * 0.25,
      decoration: BoxDecoration(
        color: status == "Done" ? Colors.white : Colors.blue.shade300,
        boxShadow: const [
          BoxShadow(color: Colors.black, blurRadius: 3),
        ],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "ORDER #$id",
                style: Theme.of(context).textTheme.displayLarge,
              ),
              InkWell(
                onTap: onClick,
                child: Text(
                  "View Detailes",
                  style: Theme.of(context).textTheme.displaySmall,
                ),
              ),
            ],
          ),
          RichText(
            text: TextSpan(
              style: DefaultTextStyle.of(context).style,
              children: [
                TextSpan(
                  text: "Date: ",
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                TextSpan(
                  text: "$date - $time",
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ],
            ),
          ),
          RichText(
            text: TextSpan(
              style: DefaultTextStyle.of(context).style,
              children: [
                TextSpan(
                  text: "Total Price: ",
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                TextSpan(
                  text: "${totalprice.toStringAsFixed(2)} JD",
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ],
            ),
          ),
          RichText(
            text: TextSpan(
              style: DefaultTextStyle.of(context).style,
              children: [
                TextSpan(
                  text: "Status: ",
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                TextSpan(
                  text: status,
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
