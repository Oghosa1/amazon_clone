// import 'package:flutter/material.dart';

// showSnackBar(BuildContext context, String text) {
//   ScaffoldMessenger.of(context).showSnackBar(
//     SnackBar(
//       content: Text(text),
//     ),
//   );
// }

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:developer' as developer;

showToast(String msg, context, color) {
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_LONG,
    textColor: color,

    // backgroundColor: bgColor
  ).then((value) {
    developer.log(msg, name: 'error');
    // debugPrint('error');
    // debugPrint(msg);
  });
}

Future<List<File>> pickImages() async {
  List<File> images = [];

  try {
    var files = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: true,
    );
    if (files != null && files.files.isNotEmpty) {
      for (int i = 0; i < files.files.length; i++) {
        images.add(File(files.files[i].path!));
      }
    }
  } catch (e) {
    debugPrint(e.toString());
    // showToast(e.toString(), context, color)
  }
  return images;
}

// class ShowToast {
//   // static showDialog(String msg, context) {
//   //   Toast.show(msg, context,
//   //       duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM, backgroundColor: Colors.blue);
//   // }

//   static toast(String msg, context, color, bgColor) {
//     Fluttertoast.showToast(
//       msg: msg,
//       toastLength: Toast.LENGTH_LONG,
//       textColor: color,
//       // backgroundColor: bgColor
//     );
//   }
// }
