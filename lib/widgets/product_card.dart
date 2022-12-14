import 'package:eat_at_home/widgets/inc_dec_buttons.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key? key,
    required this.image,
    required this.category,
    required this.name,
    required this.price,
    required this.onClick,
    required this.index,
  }) : super(key: key);

  final String image;
  final String category;
  final String name;
  final double price;
  final int index;
  final void Function() onClick;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    return Column(
      children: [
        if (index == 0 && category == "Pizza")
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(
              "Large Pizza",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline4,
            ),
          ),
        Container(
          margin: EdgeInsets.only(bottom: mq.size.height / 50),
          child: Row(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  image,
                  height: mq.size.height * 0.13,
                  width: mq.size.width * 0.28,
                  fit: category == "Drinks" ? BoxFit.contain : BoxFit.fill,
                ),
              ),
              SizedBox(width: mq.size.width * 0.05),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: mq.size.width / 3,
                    child: Text(
                      name,
                      style: const TextStyle(fontSize: 18),
                      softWrap: true,
                    ),
                  ),
                  SizedBox(height: mq.size.height / 50),
                  Text(
                    "$price JD",
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
              // CustonButton(
              //   icon: const Icon(Icons.add),
              //   color: Theme.of(context).primaryColor, //
              //   padding: 0,
              //   onClick: onClick,
              // ),
            ],
          ),
        ),
      ],
    );
  }
}
