// ignore_for_file: avoid_print

import 'package:e_commerce/controller/cart_controller.dart';
import 'package:e_commerce/controller/data.dart';
import 'package:e_commerce/controller/product_controller.dart';
import 'package:e_commerce/controller/user_controller.dart';
import 'package:e_commerce/widgets/count_dialog.dart';
import 'package:e_commerce/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/Cart.dart';

class Category extends StatelessWidget {
  const Category({
    Key? key,
    required this.category,
  }) : super(key: key);

  final String category;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => ProductController()),
          //ChangeNotifierProvider(create: (context) => CartController()),
        ],
        builder: (context, chilld) {
          var cartController = context.read<CartController>();
          var controller = context.read<ProductController>();
          controller.getProduct(category);

          return Selector<ProductController, int>(
            selector: (context, p1) => p1.product.length,
            builder: (context, length, child) {
              return length == 0
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: length,
                      itemBuilder: (BuildContext context, i) {
                        return ProductCard(
                          image:
                              "${Data.imgPath}${controller.product[i].photo}",
                          category: category,
                          name: controller.product[i].name,
                          price: controller.product[i].price,
                          onClick: () {
                            context.read<UserController>().isLogin
                                ? showDialog(
                                    context: context,
                                    builder: (context) {
                                      return CountDialog(
                                        onIncrement: () {
                                          context
                                              .read<CartController>()
                                              .increment();
                                        },
                                        onDecrement: () {
                                          context
                                              .read<CartController>()
                                              .decrement();
                                        },
                                        onConfirm: () {
                                          Navigator.of(context).pop();
                                          print(
                                              "User id add ${context.read<UserController>().userInfo!.id}");
                                          cartController.addToCart(
                                            CartP(
                                              userId: context
                                                  .read<UserController>()
                                                  .userInfo!
                                                  .id,
                                              mealId: controller.product[i].id,
                                              name: controller.product[i].name,
                                              count: context
                                                  .read<CartController>()
                                                  .count,
                                              price:
                                                  controller.product[i].price,
                                              subTotalPrice: context
                                                      .read<CartController>()
                                                      .count *
                                                  controller.product[i].price,
                                              category: category,
                                              img: controller.product[i].photo,
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  )
                                : Navigator.of(context).pushNamed("login");
                          },
                        );
                      },
                    );
            },
          );
        });
  }
}
