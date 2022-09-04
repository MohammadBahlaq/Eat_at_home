// ignore_for_file: avoid_print

import 'package:eat_at_home/controller/bill_controller.dart';
import 'package:eat_at_home/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BillP extends StatelessWidget {
  const BillP({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    return ChangeNotifierProvider.value(
      value: BillController(),
      builder: (context, child) {
        //final BillController billController = context.read<BillController>();
        //final UserController userController = context.read<UserController>();
        //billController.getBill(userController.userInfo!.id);
        //print(billController.bills.length);
        return Scaffold(
          appBar: AppBar(
            title: const Text("Your Bill"),
            centerTitle: true,
          ),
          body: Selector<BillController, int>(
            selector: (ctx, billC) => billC.bills.length,
            builder: (context, billLength, child) {
              return ListView.builder(
                itemCount: billLength,
                itemBuilder: (context, index) {
                  print(billLength);
                  return Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: mq.size.height * 0.013,
                      horizontal: mq.size.width * 0.03,
                    ),
                    child: const ListTile(
                      tileColor: Colors.blueAccent,
                      leading: Text("Bill No: 30"),
                      title: Text("In progrecess"),
                      subtitle: Text("2/9/2022 - 13:45"),
                      trailing: Text("39.18 JD"),
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
