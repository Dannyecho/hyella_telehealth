import 'package:flutter/material.dart';
import 'package:hyella_telehealth/core/constants/app_colors.dart';
import 'package:hyella_telehealth/core/constants/app_colors2.dart';

Widget reuseableText(
  String textString, {
  Color color = Colors.black,
  double fontSize = 14,
  FontWeight fontWeight = FontWeight.normal,
}) {
  return Container(
    margin: const EdgeInsets.only(
      bottom: 5,
    ),
    child: Text(
      textString,
      style:
          TextStyle(color: color, fontWeight: fontWeight, fontSize: fontSize),
    ),
  );
}

Widget buildTextField({
  required String type,
  String? hintText,
  Icon? icon,
  required void Function(String) onChange,
  void Function(String)? onSubmitted,
  FocusNode? focusNode,
}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 20),
    decoration: const BoxDecoration(
      /* border: Border.all(
        color: AppColors.lightText2,
      ), */
      borderRadius: BorderRadius.all(
        Radius.circular(15),
      ),
    ),
    child: TextFormField(
      focusNode: focusNode,
      onChanged: (value) => onChange(value),
      keyboardType: TextInputType.text,
      /* decoration: InputDecoration(
        border: InputBorder.none,
        hintText: "$hintText",
        hintStyle: const TextStyle(
          color: AppColors.lightText2,
        ),
      ), */
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.never,
        contentPadding: EdgeInsets.zero,
        prefixIcon: icon,
        focusColor: AppColors2.color1,
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors2.color1, width: 2),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors2.color1, width: 1.5),
        ),
        labelStyle: TextStyle(
          color: AppColors2.color1,
        ),
        labelText: hintText,
      ),
      onFieldSubmitted: onSubmitted,
      autocorrect: false,
      obscureText: type == 'password' ? true : false,
    ),
  );
}
