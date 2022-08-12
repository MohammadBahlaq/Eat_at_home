import 'package:e_commerce/widgets/inc_dec_buttons.dart';
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
    return Container(
      margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height / 50),
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.network(
            image,
            height: MediaQuery.of(context).size.height / 5.5,
            width: MediaQuery.of(context).size.width / 2.5,
            fit: category == "Beverages" ? BoxFit.contain : BoxFit.fill,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 3,
                child: Text(
                  name,
                  style: const TextStyle(fontSize: 18),
                  softWrap: true,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 50),
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
