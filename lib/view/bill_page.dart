// ignore_for_file: avoid_print

import 'package:eat_at_home/controller/bill_controller.dart';
import 'package:eat_at_home/controller/user_controller.dart';
import 'package:eat_at_home/widgets/bill_body.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Bill extends StatelessWidget {
  const Bill({super.key});

  @override
  Widget build(BuildContext context) {
    final BillController billController = context.read<BillController>();
    final UserController userController = context.read<UserController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Bills"),
        centerTitle: true,
        //foregroundColor: Theme.of(context).primaryColor,
        //backgroundColor: Colors.transparent,
        //elevation: 0,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await billController.getBill(userController.userInfo!.id);
        },
        child: Selector<BillController, int>(
          selector: (context, billC) => billC.loading,
          builder: (context, loading, child) {
            if (loading == 0) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return billController.bills.isEmpty
                  ? const Center(
                      child: Text("You don't have any bill", style: TextStyle(fontSize: 18)),
                    )
                  : const BillBuilder();
            }
          },
        ),
      ),
    );
  }
}
