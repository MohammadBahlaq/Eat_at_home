import 'package:eat_at_home/controller/data_controller.dart';
import 'package:eat_at_home/widgets/meal_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/bill_controller.dart';

class BillDetailes extends StatelessWidget {
  const BillDetailes({super.key});

  @override
  Widget build(BuildContext context) {
    final BillController billController = context.read<BillController>();
    final mq = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text("ORDER DETAILES"), centerTitle: true),
      body: Selector<BillController, int>(
        selector: (p0, p1) => p1.meals.length,
        builder: (context, mealsLength, child) {
          return mealsLength == 0
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  padding: EdgeInsets.only(top: mq.size.height * 0.014),
                  itemCount: mealsLength,
                  itemBuilder: (context, i) {
                    return MealCard(
                      name: billController.meals[i].name,
                      category: billController.meals[i].category,
                      image: "${Data.imgPath}${billController.meals[i].image}",
                      count: billController.meals[i].count,
                      subPrice: billController.meals[i].subPrice,
                    );
                  },
                );
        },
      ),
    );
  }
}
