// ignore_for_file: avoid_print

import 'package:eat_at_home/controller/bill_controller.dart';
import 'package:eat_at_home/widgets/bill_body.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Bill extends StatelessWidget {
  const Bill({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final BillController billController = context.read<BillController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Bill"),
        centerTitle: true,
      ),
      body: Selector<BillController, int>(
        selector: (context, billC) => billC.loading,
        builder: (context, loading, child) {
          if (loading == 0) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return billController.bills.isEmpty
                ? const Center(
                    child: Text("You don't have any bill",
                        style: TextStyle(fontSize: 18)),
                  )
                : const BillBuilder();
          }
        },
      ),
    );
  }
}
