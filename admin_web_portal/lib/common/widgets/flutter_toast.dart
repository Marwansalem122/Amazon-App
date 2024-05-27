import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

toastMessage({
  required String msg,
  Color backgroundColor = Colors.deepPurple,
  Color textColor = Colors.white,
}) {
  return Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.CENTER,
    timeInSecForIosWeb: 3,
    backgroundColor: backgroundColor,
    textColor: textColor,
    fontSize: 16,
    webPosition: "center"
  );
}
