import 'package:flutter/material.dart';
import 'package:hyella_telehealth/core/constants/app_colors.dart';

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
  String? icon,
  required void Function(String) onChange,
  void Function(String)? onSubmitted,
  FocusNode? focusNode,
}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 20),
    decoration: BoxDecoration(
      border: Border.all(
        color: AppColors.lightText2,
      ),
      borderRadius: const BorderRadius.all(
        Radius.circular(15),
      ),
    ),
    child: Row(
      children: [
        Container(
          margin: const EdgeInsets.only(
            left: 16,
            right: 8,
          ),
          width: 16,
          height: 16,
          child: Image.asset("assets/icons/$icon.png"),
        ),
        Expanded(
          child: TextFormField(
            focusNode: focusNode,
            onChanged: (value) => onChange(value),
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "$hintText",
              hintStyle: const TextStyle(
                color: AppColors.lightText2,
              ),
            ),
            onFieldSubmitted: onSubmitted,
            autocorrect: false,
            obscureText: type == 'password' ? true : false,
          ),
        ),
      ],
    ),
  );
}
