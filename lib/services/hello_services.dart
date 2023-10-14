// ignore_for_file: use_build_context_synchronously

import 'package:amazon_clone/common/error_handling.dart';
import 'package:amazon_clone/common/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../common/global_variable.dart';

void keepServerAlive({required BuildContext context}) async {
  try {
    http.Response response = await http.get(Uri.parse('$uri/hello'),
        headers: <String, String>{
          'Content-type': 'application/json; charset=UTF8'
        });

    httpErrorHandling(
        response: response,
        context: context,
        onSuccess: () {
          String res = response.body;
          showToast(res.toString(), context, Colors.teal);
        });
  } catch (e) {
    showToast(e.toString(), context, Colors.accents);
  }
}
