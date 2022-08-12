import 'package:e_commerce/widgets/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/cart_controller.dart';
import '../controller/user_controller.dart';
import '../widgets/category.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    if (context.read<UserController>().isLogin) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return CustomDialog(
                              onClick: () {
                                context.read<UserController>().setLogin = false;
                                context.read<CartController>().logoutCart();
                                Navigator.of(context).pop();
                              },
                              title: "Logout",
                              msg: "Are you sure you want to log out?");
                        },
                      );
                    } else {
                      Navigator.of(context).pushNamed("login");
                    }
                  },
                  icon: Selector<UserController, bool>(
                    selector: (context, userContr) => userContr.isLogin,
                    builder: (context, isLogin, child) {
                      return Icon(isLogin ? Icons.logout : Icons.login);
                    },
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.shopping_cart),
                  onPressed: () {
                    if (context.read<UserController>().isLogin) {
                      context.read<CartController>().getCart(
                            context.read<UserController>().userInfo!.id,
                          );
                      Navigator.pushNamed(context, "cart");
                    } else {
                      Navigator.pushNamed(context, "login");
                    }
                  },
                ),
                Selector<CartController, double>(
                  selector: (context, cart) => cart.totalPrice,
                  builder: ((context, value, child) =>
                      Text(value.toStringAsFixed(2))),
                ),
              ],
            ),
          ],
          title: const Text("Home"),
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
        body: const TabBarView(
          children: [
            Category(category: "Pizza"),
            Category(category: "Sandwich"),
            Category(category: "Salad"),
            Category(category: "Beverages"),
            Category(category: "Extra"),
          ],
        ),
      ),
    );
  }
}