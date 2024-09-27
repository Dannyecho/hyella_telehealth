import 'package:hyella_telehealth/core/utils/app_util.dart';
import 'package:hyella_telehealth/core/utils/http_util.dart';
import 'package:hyella_telehealth/data/repository/entities/app_http_response.dart';

class ProfileApi {
  Future<AppHttpResponse> updateProfilePhoto(data) async {
    try {
      // String token = AppConstants.token;
      String uri = "&nwp_request=user_mgt_update_photo";
      uri += '&public_key=${AppUtil.generateMd5(uri)}';
      var response = await HttpUtil().post(uri, data: data);
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
