// ignore_for_file: avoid_print

import 'package:eat_at_home/controller/bill_controller.dart';
import 'package:eat_at_home/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Bill extends StatelessWidget {
  const Bill({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    return ChangeNotifierProvider(
      create: (context) => BillController(),
      builder: (context, child) {
        final BillController billController = context.read<BillController>();
        final UserController userController = context.read<UserController>();
        billController.getBill(userController.userInfo!.id);
        print(billController.bills.length);
        return Scaffold(
          appBar: AppBar(
            title: const Text("Your Bill"),
            centerTitle: true,
          ),
          body: Selector<BillController, int>(
            selector: (ctx, billC) => billC.bills.length,
            builder: (context, billLength, child) {
              return billLength == 0
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: billLength,
                      itemBuilder: (context, i) {
                        print(billLength);
                        return Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: mq.size.height * 0.013,
                            horizontal: mq.size.width * 0.03,
                          ),
                          child: ListTile(
                            tileColor: billController.bills[i].status == 1
                                ? Colors.green
                                : Colors.red,
                            leading:
                                Text("Bill No: ${billController.bills[i].id}"),
                            title: Text(
                              billController.bills[i].status == 1
                                  ? "In progrecess"
                                  : "Done",
                            ),
                            subtitle: Text(
                              "${billController.bills[i].date} - ${billController.bills[i].time}",
                            ),
                            trailing: Text(
                                "${billController.bills[i].totalprice.toStringAsFixed(2)} JD"),
                          ),
                        );
                      },
                    );
            },
          ),
        );
      }, //
    ); //
  }
}
