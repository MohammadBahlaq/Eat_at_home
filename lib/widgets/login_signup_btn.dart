import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.text,
    required this.onClick,
    this.padding = 8,
    this.borderRadius = 15,
  }) : super(key: key);

  final String text;
  final void Function() onClick;
  final double padding;
  final double borderRadius;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(15),
          fixedSize: Size.fromWidth(MediaQuery.of(context).size.width),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        onPressed: onClick,
        child: Text(text, style: const TextStyle(fontSize: 18)),
      ),
    );
  }
}
