import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hyella_telehealth/core/constants/app_colors2.dart';
import 'package:hyella_telehealth/data/repository/apis/register_api.dart';
import 'package:hyella_telehealth/presentation/widgets/toast_info.dart';

class RegisterController {
  registerUser({url, formData}) async {
    EasyLoading.show(
      status: "Registering New User...",
      indicator: CircularProgressIndicator(
        color: AppColors2.color1,
      ),
      maskType: EasyLoadingMaskType.clear,
    );

    try {
      var result =
          await RegisterApi().registerNewUser(url: url, data: formData);
      if (result.type == 0) {
        EasyLoading.dismiss();
        toastInfo(msg: result.msg, backgroundColor: Colors.red);
      } else {
        EasyLoading.dismiss();
        toastInfo(msg: result.msg, backgroundColor: Colors.green);
      }
    } catch (e) {
      EasyLoading.dismiss();
      toastInfo(msg: 'Response Error', backgroundColor: Colors.red);
    }
  }
}
