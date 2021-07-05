import 'package:flutter/material.dart';

class FormButton extends StatelessWidget {
  String text;
  VoidCallback? onPressed;

  FormButton({required this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.only(left: 24.0, right: 24.0),
        child: Text(text),
      ),
    );
  }
}
