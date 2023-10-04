import 'package:amazon_clone/common/global_variable.dart';
import 'package:amazon_clone/widgets/single_product.dart';
import 'package:flutter/material.dart';

class Orders extends StatefulWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  //Tempory List
  List<String> list = [
    'https://images.unsplash.com/photo-1496181133206-80ce9b88a853',
    'https://images.unsplash.com/photo-1496181133206-80ce9b88a853',
    'https://images.unsplash.com/photo-1496181133206-80ce9b88a853',
    'https://images.unsplash.com/photo-1496181133206-80ce9b88a853',
    'https://images.unsplash.com/photo-1496181133206-80ce9b88a853',
    'https://images.unsplash.com/photo-1496181133206-80ce9b88a853',
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 15),
              child: const Text(
                'Your Orders',
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(right: 15),
              child: Text(
                'See all',
                style: TextStyle(color: GlobalVariables.selectedNavBarColor),
              ),
            ),
          ],
        ),

        //Display Orders
        Container(
          // color: Colors.red,
          height: 170,
          padding: const EdgeInsets.only(left: 10, top: 20, right: 0),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: list.length,
            itemBuilder: ((context, index) {
              try {
                return SingleProduct(
                  image: list[index].toString(),
                );
              } catch (e) {
                return const Text('Image not available');
              }
            }),
          ),
        )
      ],
    );
  }
}
