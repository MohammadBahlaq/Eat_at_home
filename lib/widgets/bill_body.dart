import 'package:eat_at_home/controller/bill_controller.dart';
import 'package:eat_at_home/view/bill_detailes.dart';
import 'package:eat_at_home/widgets/bill_card.dart';
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
      builder: (context, billLength, child) => ListView.separated(
        separatorBuilder: (context, index) => const Divider(
          thickness: 3,
          indent: 20,
          endIndent: 20,
        ),
        padding: EdgeInsets.only(top: mq.size.height * 0.02),
        itemCount: billLength,
        itemBuilder: (context, i) {
          return Selector<BillController, int>(
            selector: (p0, p1) => p1.bills[i].status,
            builder: (context, value, child) => BillCard(
              id: billController.bills[i].id!,
              onClick: () async {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      BillDetailes(orderNO: billController.bills[i].id!),
                ));
                await billController.getItems(billController.bills[i].id!);
              },
              date: billController.bills[i].date,
              time: billController.bills[i].time,
              totalprice: billController.bills[i].totalprice,
              status: billController.bills[i].status == 1
                  ? "In Progrecess"
                  : "Done",
            ),
          );
        },
      ),
    );
  }
}
