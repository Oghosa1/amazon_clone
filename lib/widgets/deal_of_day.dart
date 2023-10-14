import 'package:amazon_clone/screens/product_details_screen.dart';
import 'package:amazon_clone/services/home_service.dart';
import 'package:amazon_clone/widgets/loader.dart';
import 'package:flutter/material.dart';

import '../models/product_model.dart';

class DealOfDay extends StatefulWidget {
  const DealOfDay({super.key});

  @override
  State<DealOfDay> createState() => _DealOfDayState();
}

class _DealOfDayState extends State<DealOfDay> {
  ProductModel? productModel;
  final HomeServices homeServices = HomeServices();
  @override
  void initState() {
    super.initState();
    fetchDealOfTheDay();
  }

  void fetchDealOfTheDay() async {
    productModel = await homeServices.fetchDealOfTheDay(context: context);
    setState(() {});
  }

  void navigateToDetailScreen() {
    Navigator.pushNamed(context, ProductDetailsScreen.routeName,
        arguments: productModel);
  }

  @override
  Widget build(BuildContext context) {
    return productModel == null
        ? const Loader()
        : productModel!.name.isEmpty
            ? const Placeholder()
            : GestureDetector(
              onTap: navigateToDetailScreen,
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.only(left: 10),
                      child: const Text(
                        'Deal of the day',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Image.network(
                      productModel!.images[0],
                      height: 235,
                      width: MediaQuery.sizeOf(context).width * 0.95,
                      // fit: BoxFit.fitHeight,
                      fit: BoxFit.contain,
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      padding:
                          const EdgeInsets.only(left: 15, top: 5, right: 40),
                      child: Text(
                        '₦${productModel!.price}',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      padding:
                          const EdgeInsets.only(left: 15, top: 5, right: 40),
                      child: Text(
                        productModel!.name,
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: productModel!.images
                            .map(
                              (e) => Image.network(
                                e,
                                fit: BoxFit.fitWidth,
                                height: 100,
                                width: 100,
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 15)
                          .copyWith(left: 15),
                      alignment: Alignment.topLeft,
                      child: Text(
                        'See all deals',
                        style: TextStyle(color: Colors.cyan.shade800),
                      ),
                    )
                  ],
                ),
              );
  }
}
