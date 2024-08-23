import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hyella_telehealth/core/constants/app_colors.dart';
import 'package:hyella_telehealth/core/constants/app_colors2.dart';
import 'package:hyella_telehealth/data/repository/apis/profile_api.dart';
import 'package:hyella_telehealth/presentation/widgets/toast_info.dart';

class ProfileController {
  updateUserProfile({url, formData}) async {
    EasyLoading.show(
      status: "Updating Profile",
      indicator: CircularProgressIndicator(
        color: AppColors2.color1,
      ),
      maskType: EasyLoadingMaskType.clear,
    );

    var response = await ProfileApi().updateProfie(url, formData);
    if (response is Map && response.msg == 1) {
      EasyLoading.dismiss();
      toastInfo(msg: response.msg, backgroundColor: Colors.green);
    } else {
      EasyLoading.dismiss();
      toastInfo(msg: response.msg, backgroundColor: Colors.red);
    }
    return response;
  }
}
