import 'package:flutter/material.dart';

class CustonButton extends StatelessWidget {
  const CustonButton({
    Key? key,
    this.color = Colors.black,
    this.padding = 8,
    required this.icon,
    required this.onClick,
  }) : super(key: key);

  final Color color;

  final Icon icon;
  final double padding;
  final void Function() onClick;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: CircleAvatar(
        backgroundColor: color,
        child: IconButton(
          color: Colors.white,
          icon: icon,
          onPressed: onClick,
        ),
      ),
    );
  }
}
