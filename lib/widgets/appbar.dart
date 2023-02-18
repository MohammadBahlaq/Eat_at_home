// ignore_for_file: use_build_context_synchronously

import 'package:badges/badges.dart' as badges;
import 'package:eat_at_home/controller/bill_controller.dart';
import 'package:eat_at_home/controller/cart_controller.dart';
import 'package:eat_at_home/controller/user_controller.dart';
import 'package:eat_at_home/widgets/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, this.size = 0, this.bottom});

  final double size;
  final PreferredSizeWidget? bottom;
  @override
  Widget build(BuildContext context) {
    final CartController cartController = context.read<CartController>();
    final UserController userController = context.read<UserController>();
    final BillController billController = context.read<BillController>();

    final mq = MediaQuery.of(context);
    return AppBar(
      actions: [
        Row(
          children: [
            InkWell(
              child: SvgPicture.asset(
                "images/orders.svg",
                width: mq.size.width * 0.067,
                height: mq.size.height * 0.035,
                color: Colors.white,
              ),
              onTap: () async {
                if (userController.isLogin) {
                  Navigator.pushNamed(context, "bill");
                  billController.setLoading(0);
                  await billController.getBill(userController.userInfo!.id);
                  billController.setLoading(1);
                } else {
                  Navigator.pushNamed(context, "login");
                }
              },
            ),
            InkWell(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: badges.Badge(
                  padding: const EdgeInsets.all(3),
                  badgeContent: Selector<CartController, int>(
                    selector: (context, cartC) => cartC.countAll,
                    builder: ((context, length, child) {
                      return Text(
                        "$length",
                        style: const TextStyle(color: Colors.white),
                      );
                    }),
                  ),
                  animationType: badges.BadgeAnimationType.slide,
                  //position: BadgePosition.topEnd(end: 0, top: -4),
                  child: const Icon(
                    Icons.shopping_cart,
                    size: 25,
                  ),
                ),
              ),
              onTap: () async {
                //if (userController.isLogin) {
                Navigator.pushNamed(context, "cart");
                cartController.setLoading(0);
                await cartController.getCart(userController.userInfo!.id);
                cartController.setLoading(1);
                //} else {
                //Navigator.pushNamed(context, "login");
                //}
              },
            ),
            IconButton(
              onPressed: () {
                if (userController.isLogin) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return CustomDialog(
                          onClick: () {
                            userController.setLogin = false;
                            //cartController.logoutCart();
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
          ],
        ),
      ],
      title: const Text("Home"),
      bottom: bottom,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height +
      const TabBar(
        tabs: [],
      ).preferredSize.height +
      size);
}
