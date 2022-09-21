import 'package:badges/badges.dart';
import 'package:eat_at_home/controller/user_controller.dart';
import 'package:eat_at_home/widgets/appbar.dart';
import 'package:eat_at_home/widgets/login_signup_btn.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/cart_controller.dart';
import '../controller/product_controller.dart';
import '../widgets/category.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CartController cartController = context.read<CartController>();
    final UserController userController = context.read<UserController>();
    final ProductController productCrt = context.read<ProductController>();
    final mq = MediaQuery.of(context);
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: CustomAppBar(
          size: MediaQuery.of(context).size.height * 0.035,
          bottom: TabBar(
            onTap: (value) {
              print("Valuse:$value");
              productCrt.setCategory(value);
            },
            tabs: const [
              Tab(
                  icon: Icon(Icons.local_pizza, size: 29),
                  child: Text("Pizza")),
              Tab(
                  icon: Icon(Icons.fastfood, size: 29),
                  child: Text("Sandwich")),
              Tab(icon: Icon(Icons.food_bank, size: 29), child: Text("Salad")),
              Tab(
                  icon: Icon(Icons.local_drink, size: 29),
                  child: Text("Drinks")),
              Tab(icon: Icon(Icons.add, size: 29), child: Text("Other")),
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
                Category(category: "Drinks"),
                Category(category: "Other"),
              ],
            ),
            CustomButton(
              text: Selector<CartController, double>(
                selector: (context, p1) => p1.totalPrice,
                builder: (context, totalPrice, child) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Badge(
                            alignment: Alignment.center,
                            shape: BadgeShape.square,
                            padding: EdgeInsets.symmetric(
                              horizontal: mq.size.width * 0.013,
                              vertical: mq.size.height * 0.003,
                            ),
                            borderRadius: BorderRadius.circular(4),
                            badgeColor: Colors.blue.shade200,
                            badgeContent: Selector<CartController, int>(
                              selector: (p0, p1) => p1.countAll,
                              builder: (context, countAll, child) {
                                return Text(
                                  "$countAll ",
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(width: mq.size.width * 0.015),
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
            )
          ],
        ),
      ),
    );
  }
}
