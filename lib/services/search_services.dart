// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../common/error_handling.dart';
import '../common/global_variable.dart';
import '../common/utils.dart';
import '../models/product_model.dart';
import '../providers/user_provider.dart';

class SearchServices {
  Future<List<ProductModel>> fetchSearchedProducts(
      {required BuildContext context, required String searchQuery}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<ProductModel> productList = [];
    try {
      http.Response res = await http
          .get(Uri.parse('$uri/api/products/search/$searchQuery'), headers: {
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
}
