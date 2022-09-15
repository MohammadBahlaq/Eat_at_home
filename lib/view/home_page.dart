import 'package:eat_at_home/widgets/appbar.dart';
import 'package:eat_at_home/widgets/login_signup_btn.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/cart_controller.dart';
import '../widgets/category.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final CartController cartController = context.read<CartController>();
    // final UserController userController = context.read<UserController>();
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: CustomAppBar(
          size: MediaQuery.of(context).size.height * 0.035,
          bottom: const TabBar(
            tabs: [
              Tab(
                  icon: Icon(Icons.local_pizza, size: 29),
                  child: Text("Pizza")),
              Tab(
                  icon: Icon(Icons.fastfood, size: 29),
                  child: Text("Sandwich")),
              Tab(icon: Icon(Icons.food_bank, size: 29), child: Text("Salad")),
              Tab(
                  icon: Icon(Icons.emoji_food_beverage, size: 29),
                  child: Text("Beverages")),
              Tab(icon: Icon(Icons.add, size: 29), child: Text("Extra")),
            ],
            isScrollable: true,
          ),
        ),
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            const TabBarView(
              children: [
                Category(category: "Pizza"),
                Category(category: "Sandwich"),
                Category(category: "Salad"),
                Category(category: "Beverages"),
                Category(category: "Extra"),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: CustomButton(
                text: Selector<CartController, double>(
                  selector: (context, p1) => p1.totalPrice,
                  builder: (context, totalPrice, child) {
                    return Text(
                      "Confirm your order (${totalPrice.toStringAsFixed(2)} JD)",
                      style: const TextStyle(fontSize: 18),
                    );
                  },
                ),
                onClick: () async {},
              ),
            )
          ],
        ),
      ),
    );
  }
}
