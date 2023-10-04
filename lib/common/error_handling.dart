import 'dart:convert';

import 'package:amazon_clone/common/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void httpErrorHandling({
  required http.Response response,
  required BuildContext context,
  //VoidCallback is a short form of Function()?
  required VoidCallback onSuccess,
}) {
  switch (response.statusCode) {
    case 200:
      onSuccess();
      break;
    case 400:
      // showSnackBar(context, jsonDecode(response.body)['msg']);
      showToast(jsonDecode(response.body)['msg'], context, Colors.red);
      print(jsonDecode(response.body)['msg']);
      break;
    case 500:
      // showSnackBar(context, jsonDecode(response.body)['error']);
      showToast(jsonDecode(response.body)['msg'], context, Colors.red);
      print(jsonDecode(response.body)['msg']);
      break;
    default:
      // showSnackBar(context, response.body);
      showToast(response.body, context, Colors.red);
  }
}
