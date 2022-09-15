import 'package:eat_at_home/controller/user_controller.dart';
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
    final CartController cartController = context.read<CartController>();
    final UserController userController = context.read<UserController>();
    final mq = MediaQuery.of(context);
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
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin:
                                  EdgeInsets.only(right: mq.size.width * 0.025),
                              alignment: Alignment.center,
                              height: mq.size.height * 0.033,
                              width: mq.size.width * 0.064,
                              decoration: BoxDecoration(
                                color: Colors.blue.shade200,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                "${cartController.cart.length} ",
                                style: const TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                            ),
                            const Text(
                              "See your basket",
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                        Text(
                          "${totalPrice.toStringAsFixed(2)} JD",
                          style: const TextStyle(fontSize: 18),
                        ),
                      ],
                    );
                  },
                ),
                onClick: () async {
                  if (userController.isLogin) {
                    Navigator.pushNamed(context, "cart");
                    cartController.setLoading(0);
                    await cartController.getCart(userController.userInfo!.id);
                    cartController.setLoading(1);
                  } else {
                    Navigator.pushNamed(context, "login");
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
