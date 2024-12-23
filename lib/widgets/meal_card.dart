import 'package:flutter/material.dart';

class MealCard extends StatelessWidget {
  const MealCard({
    super.key,
    required this.image,
    required this.category,
    required this.name,
    required this.count,
    required this.subPrice,
  });

  final String name;
  final String category;
  final String image;
  final int count;
  final double subPrice;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    return Container(
      margin: EdgeInsets.only(bottom: mq.size.height / 50),
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: mq.size.width / 3,
                child: Text(
                  name,
                  style: const TextStyle(fontSize: 20),
                  softWrap: true,
                ),
              ),
              SizedBox(height: mq.size.height / 50),
              Text(
                "count: $count",
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: mq.size.height / 50),
            ],
          ),
          Text(
            "${subPrice.toStringAsFixed(2)} JD",
            style: const TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}
