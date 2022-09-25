import 'package:eat_at_home/controller/cart_controller.dart';
import 'package:eat_at_home/controller/data_controller.dart';
import 'package:eat_at_home/controller/product_controller.dart';
import 'package:eat_at_home/controller/user_controller.dart';
import 'package:eat_at_home/widgets/inc_dec_buttons.dart';
import 'package:eat_at_home/widgets/login_signup_btn.dart';
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

    return Selector<ProductController, int>(
      selector: (context, p1) => p1.product.length,
      builder: (context, length, child) {
        return length == 0
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  SizedBox(
                    height: mq.size.height * 0.7582,
                    child: ListView.separated(
                      padding: EdgeInsets.only(
                        bottom: mq.size.height * 0.060,
                        top: mq.size.height * 0.013,
                        right: mq.size.width * 0.025,
                        left: mq.size.width * 0.025,
                      ),
                      itemCount: length,
                      separatorBuilder: (context, i) {
                        if (i == 2 && category == "Pizza") {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Text(
                              "Medium Pizza",
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.headline4,
                            ),
                          );
                        } else if (i == 5 && category == "Pizza") {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Text(
                              "Small Pizza",
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.headline4,
                            ),
                          );
                        } else {
                          return const SizedBox();
                        }
                      },
                      itemBuilder: (BuildContext context, i) {
                        return InkWell(
                          child: ProductCard(
                            index: i,
                            image:
                                "${Data.imgPath}${productCrt.product[i].photo}",
                            category: category,
                            name: productCrt.product[i].name,
                            price: productCrt.product[i].price,
                            onClick: () {
                              // userCrt.isLogin
                              //     ? showDialog(
                              //         context: context,
                              //         builder: (context) {
                              //           return CountDialog(
                              //             onIncrement: () {
                              //               cartCrt.increment();
                              //             },
                              //             onDecrement: () {
                              //               cartCrt.decrement();
                              //             },
                              //             onConfirm: () async {
                              //               Navigator.of(context).pop();
                              //               await cartCrt.isExisting(
                              //                 CartP(
                              //                   userId: userCrt.userInfo!.id,
                              //                   mealId:
                              //                       productCrt.product[i].id,
                              //                   name:
                              //                       productCrt.product[i].name,
                              //                   count: cartCrt.count,
                              //                   price:
                              //                       productCrt.product[i].price,
                              //                   subTotalPrice: cartCrt.count *
                              //                       productCrt.product[i].price,
                              //                   category: category,
                              //                   img:
                              //                       productCrt.product[i].photo,
                              //                 ),
                              //               );
                              //             },
                              //           );
                              //         },
                              //       )
                              //     : Navigator.of(context).pushNamed("login");
                            },
                          ),
                          onTap: () {
                            userCrt.isLogin
                                ? showModalBottomSheet(
                                    context: context,
                                    clipBehavior: Clip.antiAlias,
                                    isScrollControlled: true,
                                    constraints: BoxConstraints(
                                      maxHeight: mq.size.height * 0.67,
                                      minHeight: mq.size.height * 0.67,
                                      maxWidth: mq.size.width,
                                      minWidth: mq.size.width,
                                    ),
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(30),
                                      ),
                                    ),
                                    builder: (context) {
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Stack(
                                            alignment: Alignment.topRight,
                                            children: [
                                              Image.network(
                                                "${Data.imgPath}${productCrt.product[i].photo}",
                                                height: mq.size.height * 0.39,
                                                width: mq.size.width,
                                                fit: productCrt.product[i]
                                                            .category ==
                                                        "Drinks"
                                                    ? BoxFit.contain
                                                    : BoxFit.fill,
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: CircleAvatar(
                                                  backgroundColor: Colors.white,
                                                  child: IconButton(
                                                    icon:
                                                        const Icon(Icons.close),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                              top: mq.size.height * 0.02,
                                              bottom: mq.size.height * 0.03,
                                              left: mq.size.width * 0.04,
                                            ),
                                            child: Text(
                                              productCrt.product[i].name,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline2,
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                              left: mq.size.width * 0.04,
                                              right: mq.size.width * 0.033,
                                              top: mq.size.height * 0.02,
                                              bottom: mq.size.height * 0.02,
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "${productCrt.product[i].price} JD",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline2,
                                                ),
                                                Card(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      IncDecButton(
                                                        icon: const Icon(
                                                            Icons.add,
                                                            color:
                                                                Colors.green),
                                                        color:
                                                            Colors.transparent,
                                                        onClick: () {
                                                          cartCrt.increment();
                                                        },
                                                      ),
                                                      Selector<CartController,
                                                          int>(
                                                        selector:
                                                            (context, p1) {
                                                          return p1.count;
                                                        },
                                                        builder: (context,
                                                            count, child) {
                                                          return Text(
                                                            "$count",
                                                            style:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        18),
                                                          );
                                                        },
                                                      ),
                                                      IncDecButton(
                                                        icon: const Icon(
                                                            Icons.remove,
                                                            color: Colors.red),
                                                        color:
                                                            Colors.transparent,
                                                        onClick: () {
                                                          cartCrt.decrement();
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          CustomButton(
                                            text: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const Text(
                                                  "Add to cart",
                                                  style:
                                                      TextStyle(fontSize: 18),
                                                ),
                                                Selector<CartController, int>(
                                                  selector: (p0, p1) =>
                                                      p1.count,
                                                  builder:
                                                      (context, value, child) {
                                                    return Text(
                                                      "${(productCrt.product[i].price * cartCrt.count).toStringAsFixed(2)} JD",
                                                      style: const TextStyle(
                                                          fontSize: 18),
                                                    );
                                                  },
                                                ),
                                              ],
                                            ),
                                            onClick: () async {
                                              Navigator.of(context).pop();

                                              await cartCrt.isExisting(
                                                CartP(
                                                  userId: userCrt.userInfo!.id,
                                                  mealId:
                                                      productCrt.product[i].id,
                                                  name: productCrt
                                                      .product[i].name,
                                                  count: cartCrt.count,
                                                  price: productCrt
                                                      .product[i].price,
                                                  subTotalPrice: cartCrt.count *
                                                      productCrt
                                                          .product[i].price,
                                                  category: category,
                                                  img: productCrt
                                                      .product[i].photo,
                                                ),
                                              );
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  )
                                : Navigator.of(context).pushNamed("login");
                            ;
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
