import 'package:fluttertoast/fluttertoast.dart';

class ShowToast {
  // static showDialog(String msg, context) {
  //   Toast.show(msg, context,
  //       duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM, backgroundColor: Colors.blue);
  // }

  static toast(String msg, context, color, bgColor) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      textColor: color,
      backgroundColor: bgColor
    );
  }
}
