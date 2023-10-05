// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:amazon_clone/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../common/error_handling.dart';
import '../common/global_variable.dart';
import '../common/utils.dart';
import '../providers/user_provider.dart';

class ProductDetailsServices {
  void rateProduct({
    required BuildContext context,
    required ProductModel productModel,
    required double rating,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response response =
          await http.post(Uri.parse('$uri/api/rate-product'),
              headers: <String, String>{
                'Content-type': 'application/json; charset=UTF-8',
                'x-auth-token': userProvider.user.token,
              },
              // body: productModel.toJson(),
              body: jsonEncode({
                'id': productModel.id!,
                'rating': rating,
              }));
      httpErrorHandling(
        response: response,
        context: context,
        onSuccess: () {
        },
      );
    } catch (e) {
      showToast(e.toString(), context, Colors.white);
    }
  }
}
