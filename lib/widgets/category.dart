import 'package:eat_at_home/controller/cart_controller.dart';
import 'package:eat_at_home/controller/data_controller.dart';
import 'package:eat_at_home/controller/product_controller.dart';
import 'package:eat_at_home/controller/user_controller.dart';
import 'package:eat_at_home/main.dart';
import 'package:eat_at_home/widgets/count_dialog.dart';
import 'package:eat_at_home/widgets/product_card.dart';
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
    final CartController cartCrt = context.read<CartController>();
    final ProductController productCrt = context.read<ProductController>();
    final UserController userCrt = context.read<UserController>();
    final mq = MediaQuery.of(context);
    //print("Build category");
    //productCrt.setCategory(category);
    //productCrt.getProduct(category);

    return Selector<ProductController, int>(
      selector: (context, p1) => p1.product.length,
      builder: (context, length, child) {
        return length == 0
            ? const Center(child: CircularProgressIndicator())
            : Column(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // if (category == "Pizza")
                  // Text(
                  //   "Large Pizza",
                  //   textAlign: TextAlign.center,
                  //   style: Theme.of(context).textTheme.headline4,
                  // ),
                  SizedBox(
                    height: mq.size.height * 0.7582,
                    child: ListView.separated(
                      //physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.only(
                        bottom: mq.size.height * 0.075,
                        top: mq.size.height * 0.013,
                        right: mq.size.width * 0.025,
                        left: mq.size.width * 0.025,
                      ),
                      itemCount: length,
                      separatorBuilder: (context, i) {
                        if (i == 2 && category == "Pizza") {
                          return Text(
                            "Medium Pizza",
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headline4,
                          );
                        } else if (i == 5 && category == "Pizza") {
                          return Text(
                            "Small Pizza",
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headline4,
                          );
                        } else {
                          return const SizedBox();
                        }
                      },
                      itemBuilder: (BuildContext context, i) {
                        return ProductCard(
                          index: i,
                          image:
                              "${Data.imgPath}${productCrt.product[i].photo}",
                          category: category,
                          name: productCrt.product[i].name,
                          price: productCrt.product[i].price,
                          onClick: () {
                            userCrt.isLogin
                                ? showDialog(
                                    context: context,
                                    builder: (context) {
                                      return CountDialog(
                                        onIncrement: () {
                                          cartCrt.increment();
                                        },
                                        onDecrement: () {
                                          cartCrt.decrement();
                                        },
                                        onConfirm: () async {
                                          Navigator.of(context).pop();

                                          await cartCrt.isExisting(
                                            CartP(
                                              userId: userCrt.userInfo!.id,
                                              mealId: productCrt.product[i].id,
                                              name: productCrt.product[i].name,
                                              count: cartCrt.count,
                                              price:
                                                  productCrt.product[i].price,
                                              subTotalPrice: cartCrt.count *
                                                  productCrt.product[i].price,
                                              category: category,
                                              img: productCrt.product[i].photo,
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
                    ),
                  ),
                ],
              );
      },
    );
  }
}
