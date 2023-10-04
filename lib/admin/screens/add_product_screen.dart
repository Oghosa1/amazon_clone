import 'dart:io';
import 'package:amazon_clone/common/product_categories.dart';
import 'package:amazon_clone/common/utils.dart';
import 'package:amazon_clone/services/admin_services.dart';
import 'package:amazon_clone/widgets/custom_textfield.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import '../../common/global_variable.dart';
import '../../widgets/custom_button.dart';

class AddProductScreen extends StatefulWidget {
  static const String routeName = '/add-product';
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final AdminServices adminServices = AdminServices();
  final _addProductFormKey = GlobalKey<FormState>();

//Dispose method
  @override
  void dispose() {
    super.dispose();
    productNameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    quantityController.dispose();
  }

  // List<String> productCategories = [
  //   'Mobiles',
  //   'Essentials',
  //   'Appliances',
  //   'Books',
  //   'Fashion',
  //   'Laptops'
  // ];

  String defaultCategory = 'Mobiles';

  List<File> images = [];

  void sellProduct() {
    if (_addProductFormKey.currentState!.validate() && images.isNotEmpty) {
      adminServices.sellProduct(
        context: context,
        name: productNameController.text,
        description: descriptionController.text,
        price: double.parse(priceController.text),
        quantity: double.parse(quantityController.text),
        category: defaultCategory,
        images: images,
      );
    }
  }

  void selectImages() async {
    var res = await pickImages();
    setState(() {
      images = res;
    });
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
          title: const Text(
            'Add Product',
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _addProductFormKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                const SizedBox(height: 20),
                images.isNotEmpty
                    ? CarouselSlider(
                        items: images.map((e) {
                          return Builder(
                            builder: (BuildContext context) => Image.file(
                              e,
                              fit: BoxFit.fill,
                              // height: 200,
                              // width: 200,
                            ),
                          );
                        }).toList(),
                        options: CarouselOptions(
                          viewportFraction: 1,
                          height: 300,
                          autoPlay: true,
                          autoPlayInterval: const Duration(seconds: 3),
                          autoPlayAnimationDuration:
                              const Duration(milliseconds: 800),
                          autoPlayCurve: Curves.fastOutSlowIn,
                        ),
                      )
                    : GestureDetector(
                        onTap: selectImages,
                        child: DottedBorder(
                          borderType: BorderType.RRect,
                          radius: const Radius.circular(10),
                          dashPattern: const [10, 4],
                          strokeCap: StrokeCap.round,
                          child: Container(
                            width: double.infinity,
                            height: 150,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.folder_open,
                                  size: 40,
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  'Select Product Images',
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.grey.shade400),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                const SizedBox(height: 30),
                CustomsTextfield(
                    controller: productNameController,
                    hintText: 'Product Name'),
                const SizedBox(height: 10),
                CustomsTextfield(
                  controller: descriptionController,
                  hintText: 'Description',
                  maxLines: 7,
                ),
                const SizedBox(height: 10),
                CustomsTextfield(
                  controller: priceController,
                  hintText: 'Price',
                ),
                const SizedBox(height: 10),
                CustomsTextfield(
                  controller: quantityController,
                  hintText: 'Quantity Available',
                ),
                SizedBox(
                  width: double.infinity,
                  child: DropdownButton(
                    value: defaultCategory,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items:
                        ProductCategories.productCategories.map((String item) {
                      return DropdownMenuItem(
                        value: item,
                        child: Text(item),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        defaultCategory = newValue!;
                      });
                    },
                  ),
                ),
                CustomButton(
                  text: 'Sell',
                  textColor: Colors.white,
                  color: GlobalVariables.secondaryColor,
                  onTap: sellProduct,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
