import 'package:flutter/material.dart';

class SingleProduct extends StatelessWidget {
  final String image;

  const SingleProduct({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black12, width: 1.5),
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
        ),
        child: Image.network(
          image,
          fit: BoxFit.fitHeight, // Adjust the fit property as needed
          width: double.infinity, // Adjust the height as needed
        ),
      ),
    );
  }
}
