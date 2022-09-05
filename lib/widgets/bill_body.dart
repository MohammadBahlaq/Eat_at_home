import 'package:eat_at_home/controller/bill_controller.dart';
import 'package:eat_at_home/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BillBuilder extends StatelessWidget {
  const BillBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    final BillController billController = context.read<BillController>();
    final mq = MediaQuery.of(context);

    return Selector<BillController, int>(
      selector: (p0, p1) => p1.bills.length,
      builder: (context, billLength, child) => ListView.builder(
        itemCount: billLength,
        itemBuilder: (context, i) {
          return Padding(
            padding: EdgeInsets.symmetric(
              vertical: mq.size.height * 0.013,
              horizontal: mq.size.width * 0.03,
            ),
            child: ListTile(
              tileColor: billController.bills[i].status == 1
                  ? Colors.green
                  : Colors.red,
              leading: Text("Bill No: ${billController.bills[i].id}"),
              title: Text(
                billController.bills[i].status == 1 ? "In progrecess" : "Done",
              ),
              subtitle: Text(
                "${billController.bills[i].date} - ${billController.bills[i].time}",
              ),
              trailing: Text(
                  "${billController.bills[i].totalprice.toStringAsFixed(2)} JD"),
            ),
          );
        },
      ),
    );
  }
}
