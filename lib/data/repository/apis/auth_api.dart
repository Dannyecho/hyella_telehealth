import 'package:hyella_telehealth/core/utils/app_util.dart';
import 'package:hyella_telehealth/core/utils/http_util.dart';
import 'package:hyella_telehealth/data/repository/entities/app_http_response.dart';
import 'package:hyella_telehealth/data/repository/entities/login_request_entity.dart';
import 'package:hyella_telehealth/data/repository/entities/login_response_entity.dart';

class AuthApi {
  Future<LoginResponseEntity> updateUserInfo(isDoctor) async {
    try {
      String requestType = 'user_mgt_home_info';
      if (isDoctor) {
        requestType = 'user_mgts_home_info';
      }
      String publicKey = AppUtil.generateMd5ForApiAuth(requestType);
      String uri = 'nwp_request=$requestType&public_key=$publicKey';
      var response = await HttpUtil().post(uri);

      return LoginResponseEntity.fromJson(response);
    } catch (e) {
      return LoginResponseEntity(
        type: 0,
        msg: "Error on updating user info",
        data: null,
      );
    }
  }

  Future<LoginResponseEntity> loginUser(LoginRequestEntity request) async {
    String? requestType = request.uType;
    String publicKey = AppUtil.generateMd5ForApiAuth(requestType!);
    String uri =
        'nwp_request=$requestType&fmc_token=${request.fcmToken}&u_type=${request.uType}&public_key=$publicKey';
    var response = await HttpUtil().post(uri, data: request.toMap())
        as Map<String, dynamic>;

    return LoginResponseEntity.fromJson(response);
  }

  Future<AppHttpResponse> resetPassword(String email, bool isDoctor) async {
    try {
      String requestType = 'user_mgt_reset';
      if (isDoctor) {
        requestType = 'user_mgts_reset';
      }
      String publicKey = AppUtil.generateMd5ForApiAuth(requestType);
      String uri = 'nwp_request=$requestType&public_key=$publicKey';

      var response = await HttpUtil().post(uri, data: {
        'email': email,
        'u_type': requestType,
      });

      return AppHttpResponse.fromMap(response);
    } catch (e) {
      return AppHttpResponse(
          type: 0,
          msg:
              "Unable to reset password at the moment, please try again later");
    }
  }
}
