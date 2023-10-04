import 'package:amazon_clone/models/product_model.dart';
import 'package:amazon_clone/screens/product_details.dart';
import 'package:amazon_clone/services/home_service.dart';
import 'package:amazon_clone/widgets/loader.dart';
import 'package:flutter/material.dart';

import '../common/assets.dart';
import '../common/global_variable.dart';

class CategoryDealsScreen extends StatefulWidget {
  final String category;
  static const String routeName = '/category';
  const CategoryDealsScreen({super.key, required this.category});

  @override
  State<CategoryDealsScreen> createState() => _CategoryDealsScreenState();
}

class _CategoryDealsScreenState extends State<CategoryDealsScreen> {
  List<ProductModel>? productList;
  final HomeServices homeServices = HomeServices();
  fetchCategoryProducts() async {
    productList = await homeServices.fetchCategoryProducts(
        context: context, category: widget.category);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchCategoryProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration:
                const BoxDecoration(gradient: GlobalVariables.appBarGradient),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: Image.asset(
                  Assets.Amazon,
                  width: 200,
                  height: 100,
                  // color: Colors.black ,
                ),
              ),
              Container(
                alignment: Alignment.topRight,
                child: Text(
                  widget.category,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
      body: productList == null
          ? const Loader()
          : Column(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Keep shopping for ${widget.category}',
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
                SizedBox(
                  height: 170,
                  child: GridView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.only(left: 15),
                    itemCount: productList!.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            childAspectRatio: 1.4,
                            mainAxisSpacing: 10),
                    itemBuilder: (context, index) {
                      final product = productList![index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                              context, ProductDetailsScreen.routeName,
                              arguments: product);
                        },
                        child: Column(
                          children: [
                            SizedBox(
                              height: 130,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black12,
                                    width: 0.5,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Image.network(product.images[0]),
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.topLeft,
                              padding: const EdgeInsets.only(
                                  left: 0, top: 5, right: 15),
                              child: Text(
                                product.name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
    );
  }
}
