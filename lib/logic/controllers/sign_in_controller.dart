import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hyella_telehealth/core/constants/app_constants.dart';
import 'package:hyella_telehealth/core/global.dart';
import 'package:hyella_telehealth/data/repository/apis/auth_api.dart';
import 'package:hyella_telehealth/data/repository/entities/login_request_entity.dart';
import 'package:hyella_telehealth/data/repository/entities/login_response_entity.dart';
import 'package:hyella_telehealth/logic/bloc/sign_in_bloc.dart';
import 'package:hyella_telehealth/presentation/route/app_route.dart';
import 'package:hyella_telehealth/presentation/widgets/toast_info.dart';

class SignInController {
  final BuildContext context;
  const SignInController(this.context);

  void handleSignIn() async {
    try {
      EasyLoading.show(
        indicator: const CircularProgressIndicator(),
        maskType: EasyLoadingMaskType.clear,
        dismissOnTap: true,
      );
      final state = context.read<SignInBloc>().state;
      String emailAddress = state.email;
      String password = state.password;

      bool error = false;
      String errMsg = '';

      if (emailAddress.isEmpty) {
        error = true;
        errMsg = 'Please provide an email';
      }

      if (!RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(emailAddress)) {
        error = true;
        errMsg = 'Please provide a valid email address';
      }

      if (password.isEmpty) {
        error = true;
        errMsg = 'Please enter your password';
      }

      if (error) {
        EasyLoading.dismiss();
        toastInfo(msg: errMsg);
      }

      try {
        String? fcmToken = await FirebaseMessaging.instance.getToken();
        var loginRequest = LoginRequestEntity(
          email: emailAddress,
          password: password,
          uType: state.userType,
          fcmToken: fcmToken,
        );

        var result = await AuthApi().loginUser(loginRequest);
        if (result.type == 0) {
          EasyLoading.dismiss();
          toastInfo(msg: result.msg!, backgroundColor: Colors.red);
          return;
        }
        User user = result.data!.user!;
        await Global.storageService.setString(
            AppConstants.STORAGE_USER_PROFILE_KEY, jsonEncode(user.toJson()));
        await Global.storageService
            .setString(AppConstants.STORAGE_USER_TOKEN_KEY, user.pid!);
        await Global.storageService.setString(
            AppConstants.STORAGE_APP_DATA, jsonEncode(result.data!.toJson()));
        await Global.storageService.setBool(
            AppConstants.STORAGE_USER_IS_PATIENT, user.isPatient! == 1);

        if (context.mounted) {
          EasyLoading.dismiss();
          Navigator.of(context).popAndPushNamed(
            AppRoute.home,
            arguments: user,
          );
        }
      } catch (e) {
        EasyLoading.dismiss();
        toastInfo(
            msg: 'Invalid Response',
            backgroundColor: Colors.red,
            length: Toast.LENGTH_LONG);
      }
    } catch (e) {}
  }

/*   Future<void> asyncPostAllDate(LoginRequestEntity loginRequestEntity) async {
    var response = await UserAPI.login(params: loginRequestEntity);
    if (response.code! == 200) {
      try {
        UserItem data = response.data!;
        Global.storageService
            .setString(AppConstants.STORAGE_USER_PROFILE_KEY, jsonEncode(data));

        Global.storageService
            .setString(AppConstants.STORAGE_USER_TOKEN_KEY, data.token!);
        if (context.mounted) {
          Navigator.of(context).popAndPushNamed(AppRoute.home);
          EasyLoading.dismiss();
        }
      } catch (e) {
        EasyLoading.dismiss();
        print("Saving local storage error: ${e.toString()} on line:${e}");
      }
    } else {
      EasyLoading.dismiss();
      toastInfo(msg: "Unknown user");
    }
  }
 */
}
