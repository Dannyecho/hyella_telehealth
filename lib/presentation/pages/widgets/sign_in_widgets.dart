part of '../sign_in_page.dart';

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

TextButton forgotPassword() {
  return TextButton(
    onPressed: () {},
    child: const Text(
      "Forgot password?",
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        decoration: TextDecoration.underline,
        decorationColor: AppColors.lightText,
        color: Colors.grey,
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
          color: type == 'login' ? AppColors.primaryColor : Colors.white,
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
          color: type == 'login' ? Colors.white : AppColors.primaryColor,
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
    centerTitle: true,
    title: Text(
      title,
      textAlign: TextAlign.center,
      style: const TextStyle(
        color: AppColors.primaryColor,
        fontSize: 16.0,
        fontWeight: FontWeight.normal,
      ),
    ),
  );
}
