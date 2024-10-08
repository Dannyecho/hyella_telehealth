/* 
Center buildThirdPartyLogin(BuildContext context) {
  return Center(
    child: Container(
      margin: const EdgeInsets.only(
        top: 40,
        bottom: 20,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 45),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          reuseableIconButton('google'),
          reuseableIconButton('apple'),
          reuseableIconButton('facebook'),
        ],
      ),
    ),
  );
}
 */
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hyella_telehealth/core/constants/app_colors.dart';
import 'package:hyella_telehealth/core/constants/app_colors2.dart';
import 'package:hyella_telehealth/presentation/route/app_route.dart';

IconButton reuseableIconButton(String IconName) {
  return IconButton(
    onPressed: () {},
    icon: SizedBox(
      height: 40,
      width: 40,
      child: Image.asset(
        'assets/icons/$IconName.png',
      ),
    ),
  );
}

TextButton forgotPassword(BuildContext context) {
  return TextButton(
    onPressed: () {
      Navigator.pushNamed(context, AppRoute.forgetPassword);
    },
    child: Text(
      "Forgot password?",
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        decoration: TextDecoration.underline,
        decorationColor: AppColors2.color1,
        color: Colors.black,
      ),
    ),
  );
}

Widget loginAndRegisterButton({
  required String text,
  required type,
  void Function()? onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: 54,
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: type == 'login' ? AppColors2.color1 : Colors.white,
          borderRadius: const BorderRadius.all(
            Radius.circular(16),
          ),
          border: Border.all(
            color: type == 'login' ? Colors.transparent : AppColors.lightText2,
          ),
          boxShadow: const [
            BoxShadow(
              color: AppColors.lightText,
              spreadRadius: 1,
              blurRadius: 2,
              offset: Offset(0, 1),
            )
          ]),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: type == 'login' ? Colors.white : AppColors2.color1,
        ),
      ),
    ),
  );
}

AppBar buildAppBar({required String title}) {
  return AppBar(
    backgroundColor: Colors.white,
    bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1.0),
        child: Container(
          height: 1.0,
          color: Colors.white,
        )),
    // centerTitle: true,
    title: Text(
      title,
      // textAlign: TextAlign.center,
      style: GoogleFonts.satisfy(
        color: AppColors2.color1,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
