import 'package:hyella_telehealth/core/constants/app_constants.dart';
import 'package:hyella_telehealth/core/utils/app_util.dart';
import 'package:hyella_telehealth/core/utils/http_util.dart';
import 'package:hyella_telehealth/data/repository/entities/login_request_entity.dart';
import 'package:hyella_telehealth/data/repository/entities/login_response_entity.dart';

class AuthApi {
  Future<LoginResponseEntity> loginUser(LoginRequestEntity request) async {
    String token = AppConstants.token;

    String? requestType = request.uType;
    String publicKey = AppUtil.generateMd5ForApiAuth(requestType!);
    String uri = 'nwp_request=$requestType&token=$token&public_key=$publicKey';
    var response = await HttpUtil().post(uri, data: request.toMap())
        as Map<String, dynamic>;

    return LoginResponseEntity.fromJson(response);
  }
}
