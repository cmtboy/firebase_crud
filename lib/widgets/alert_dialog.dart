import 'package:flutter/material.dart';

class AlertDialogWidget extends StatelessWidget {
  final String text;
  final BuildContext context;

  const AlertDialogWidget({Key? key, required this.text, required this.context})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Alert"),
      content: Text(text),
      actions: [
        TextButton(
          child: const Text("Close"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
