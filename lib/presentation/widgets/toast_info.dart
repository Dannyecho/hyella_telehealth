import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

toastInfo({
  required String msg,
  Color textColor = Colors.white,
  Color backgroundColor = Colors.black54,
  Toast length = Toast.LENGTH_SHORT,
}) {
  return Fluttertoast.showToast(
    msg: msg,
    toastLength: length,
    timeInSecForIosWeb: 2,
    fontSize: 16,
    backgroundColor: backgroundColor,
    textColor: textColor,
    gravity: ToastGravity.TOP,
  );
}
