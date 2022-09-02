import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog({
    Key? key,
    required this.onClick,
    required this.title,
    required this.msg,
  }) : super(key: key);

  final void Function() onClick;
  final String title;
  final String msg;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    return AlertDialog(
      title: Text(title, style: const TextStyle(color: Colors.red)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            msg,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 18),
          ),
          SizedBox(height: mq.size.height / 36),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              fixedSize: Size(
                mq.size.width / 2,
                mq.size.height / 20,
              ),
            ),
            onPressed: onClick,
            child: const Text("OK"),
          ),
        ],
      ),
      contentPadding: const EdgeInsets.all(10),
    );
  }
}
