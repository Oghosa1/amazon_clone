import 'package:amazon_clone/models/product_model.dart';
import 'package:amazon_clone/widgets/stars.dart';
import 'package:flutter/material.dart';

class SearchedProduct extends StatelessWidget {
  final ProductModel product;
  const SearchedProduct({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    double avgRating = 0;
    double myRating = 0;
    double totalRating = 0;
    // Loop through each rating in the productModel's list of ratings.
    for (int i = 0; i < product.rating!.length; i++) {
      // Add the rating to the totalRating variable.
      totalRating += product.rating![i].rating;
    }

    if (totalRating != 0) {
      avgRating = totalRating / product.rating!.length;
    }
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Image.network(
                product.images[0],
                fit: BoxFit.fitWidth,
                height: 135,
                width: 135,
              ),
              Column(
                children: [
                  Container(
                    width: 235,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      product.name,
                      style: const TextStyle(fontSize: 16),
                      maxLines: 2,
                    ),
                  ),
                  Container(
                    width: 235,
                    padding: const EdgeInsets.only(left: 10, top: 5),
                    child: Stars(rating: avgRating),
                  ),
                  Container(
                    width: 235,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      '₦${product.price}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    width: 235,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: const Text('Eligible for Free shipping'),
                  ),
                  Container(
                    width: 235,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: const Text(
                      'In Stock',
                      style: TextStyle(color: Colors.teal),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
