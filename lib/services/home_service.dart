// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:amazon_clone/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../common/error_handling.dart';
import '../common/global_variable.dart';
import '../common/utils.dart';
import '../providers/user_provider.dart';

class HomeServices {
  Future<List<ProductModel>> fetchCategoryProducts(
      {required BuildContext context, required String category}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<ProductModel> productList = [];
    try {
      http.Response res =
          // await http.get(Uri.parse('$uri/api/products?category=$category'),
          await http
              .get(Uri.parse('$uri/api/products?category=$category'), headers: {
        // 'Content-type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      });
      

      httpErrorHandling(
        response: res,
        context: context,
        onSuccess: () {
          final List<dynamic> jsonData = jsonDecode(res.body);
          for (int i = 0; i < jsonData.length; i++) {
            productList.add(
              ProductModel.fromMap(jsonData[i]),
            );
          }
        },
      );
    } catch (e) {
      showToast(e.toString(), context, Colors.red);
    }
    return productList;
  }

  Future<ProductModel> fetchDealOfTheDay({
    required BuildContext context,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    ProductModel product = ProductModel(
        name: '',
        description: '',
        quantity: 0,
        images: [],
        category: '',
        price: 0,
        publicId: '');
    try {
      http.Response res =
          // await http.get(Uri.parse('$uri/api/products?category=$category'),
          await http.get(Uri.parse('$uri/api/deal-of-the-day'), headers: {
        // 'Content-type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      });

      httpErrorHandling(
        response: res,
        context: context,
        onSuccess: () {
          product = ProductModel.fromJson(res.body);
        },
      );
    } catch (e) {
      showToast(e.toString(), context, Colors.red);
    }
    return product ;
  }
}
