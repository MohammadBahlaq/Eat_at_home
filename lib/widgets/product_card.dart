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
  }) : super(key: key);

  final String image;
  final String category;
  final String name;
  final double price;
  final void Function() onClick;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    return Container(
      margin: EdgeInsets.only(bottom: mq.size.height / 50),
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.network(
            image,
            height: mq.size.height / 5.5,
            width: mq.size.width / 2.5,
            fit: category == "Beverages" ? BoxFit.contain : BoxFit.fill,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
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
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          CustonButton(
            icon: const Icon(Icons.add),
            padding: 0,
            onClick: onClick,
          ),
        ],
      ),
    );
  }
}
