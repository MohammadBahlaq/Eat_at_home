import 'package:eat_at_home/controller/bill_controller.dart';
import 'package:eat_at_home/widgets/order_card.dart';
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
        padding: EdgeInsets.only(top: mq.size.height * 0.02),
        itemCount: billLength,
        itemBuilder: (context, i) {
          return Padding(
            padding: EdgeInsets.symmetric(
              vertical: mq.size.height * 0.013,
              horizontal: mq.size.width * 0.03,
            ),
            child: Material(
              elevation: 2,
              shape: Theme.of(context).listTileTheme.shape,
              child:
                  // OrderCard(
                  //   index: i,
                  //   orderId: billController.bills[i].id!,
                  //   totalPrice: billController.bills[i].totalprice,
                  //   date: billController.bills[i].date,
                  //   time: billController.bills[i].time,
                  //   status: billController.bills[i].status,
                  //   mobile: "0770355390",
                  //   onCadrClick: () {},
                  // ),
                  ListTile(
                contentPadding: EdgeInsets.symmetric(
                  vertical: mq.size.height * 0.013,
                  horizontal: mq.size.width * 0.03,
                ),
                tileColor: billController.bills[i].status == 1
                    ? Theme.of(context).primaryColor
                    : Colors.grey,
                enabled: billController.bills[i].status == 1 ? true : false,
                leading: Text(
                  "Bill No: ${billController.bills[i].id}",
                  style: const TextStyle(fontSize: 18),
                ),
                title: Text(
                  billController.bills[i].status == 1
                      ? "In progrecess"
                      : "Done",
                  style: const TextStyle(fontSize: 18),
                ),
                subtitle: Text(
                  "${billController.bills[i].date} - ${billController.bills[i].time}",
                  style: const TextStyle(fontSize: 15),
                ),
                trailing: Text(
                  "${billController.bills[i].totalprice.toStringAsFixed(2)} JD",
                  style: const TextStyle(fontSize: 16),
                ),
                onTap: () async {
                  Navigator.of(context).pushNamed("detailes");
                  await billController.getItems(billController.bills[i].id!);
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
