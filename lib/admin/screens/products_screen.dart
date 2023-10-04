import 'package:amazon_clone/admin/screens/add_product_screen.dart';
import 'package:amazon_clone/common/global_variable.dart';
import 'package:amazon_clone/models/product_model.dart';
import 'package:amazon_clone/services/admin_services.dart';
import 'package:amazon_clone/widgets/loader.dart';
import 'package:amazon_clone/widgets/single_product.dart';
import 'package:flutter/material.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<ProductScreen> {
  List<ProductModel>? productsModel;
  final AdminServices adminServices = AdminServices();

  @override
  void initState() {
    super.initState();
    fetchAllProduct();
  }

  fetchAllProduct() async {
    productsModel = await adminServices.fetchAllProducts(context);
    setState(() {});
  }

  void deleteProduct(ProductModel productModel, int index) {
    adminServices.deleteProduct(
        context: context,
        productModel: productModel,
        onSuccess: () {
          productsModel!.removeAt(index);
          setState(() {});
        });
  }

  void navigateToAddProduct() {
    Navigator.pushNamed(context, AddProductScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return productsModel == null
        ? const Loader()
        : Scaffold(
            body: GridView.builder(
              itemCount: productsModel!.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemBuilder: (context, index) {
                final proudctData = productsModel![index];
                return Column(
                  children: [
                    Expanded(
                      child: SingleProduct(
                        image: proudctData.images[0],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Text(
                            proudctData.name,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                        Expanded(
                          child: IconButton(
                            onPressed: () => deleteProduct(proudctData, index),
                            icon: const Icon(Icons.delete_outline),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: GlobalVariables.selectedNavBarColor,
              onPressed: () {
                navigateToAddProduct();
              },
              tooltip: 'Add a product',
              child: const Icon(Icons.add),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
  }
}
