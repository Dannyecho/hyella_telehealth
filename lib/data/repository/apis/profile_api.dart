import 'package:dio/dio.dart';
import 'package:hyella_telehealth/core/global.dart';
import 'package:hyella_telehealth/core/utils/app_util.dart';
import 'package:hyella_telehealth/core/utils/http_util.dart';
import 'package:hyella_telehealth/data/repository/entities/app_http_response.dart';
import 'package:hyella_telehealth/data/repository/entities/login_response_entity.dart';

class ProfileApi {
  Future<AppHttpResponse> updateProfilePhoto(String imgPath) async {
    try {
      // String token = AppConstants.token;
      User appUser = Global.storageService.getAppUser()!;
      bool isDoctor = appUser.isStaff == 1;
      String uri = "&nwp_request=user_mgt_update_photo";

      if (isDoctor) {
        uri = "&nwp_request=user_mgts_update_photo";
      }
      var formData = FormData.fromMap({
        'display_picture': await MultipartFile.fromFile(imgPath),
        'first_name': appUser.firstName,
        'last_name': appUser.lastName,
        'email': appUser.email,
        'phone': appUser.phone,
        'address': appUser.address,
      });

      uri += '&public_key=${AppUtil.generateMd5(uri)}';
      var response = await HttpUtil().post(
        uri,
        data: formData,
      );
      return AppHttpResponse.fromMap(response);
    } catch (e) {
      return AppHttpResponse(
          type: 0,
          msg:
              "Unable to update profile picture at the moment. Please try again later");
    }
  }

  Future<AppHttpResponse> updateProfie(url, data) async {
    try {
      // String token = AppConstants.token;

      url += '&public_key=${AppUtil.generateMd5(url)}';
      var response = await HttpUtil().post(url, data: data);
      return AppHttpResponse.fromMap(response);
    } catch (e) {
      return AppHttpResponse(type: 0, msg: "Response error!");
    }
  }
}
