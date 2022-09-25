import 'package:flutter/material.dart';

class IncDecButton extends StatelessWidget {
  const IncDecButton({
    Key? key,
    this.color = Colors.transparent,
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
      padding: EdgeInsets.symmetric(horizontal: padding),
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
