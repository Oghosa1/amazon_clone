import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Color? color;
  final Color? textColor;
  final VoidCallback onTap;
  const CustomButton({
    Key? key,
    required this.text,
    required this.onTap,
    this.color,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
          backgroundColor: color, minimumSize: const Size(double.infinity, 50)),
      child: Text(
        text,
        style: TextStyle(color: textColor ?? Colors.white),
        // style: TextStyle(color: color == null ? Colors.white : Colors.black),
      ),
    );
  }
}
