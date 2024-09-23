import 'package:hyella_telehealth/core/utils/app_util.dart';
import 'package:hyella_telehealth/core/utils/http_util.dart';
import 'package:hyella_telehealth/data/repository/entities/app_http_response.dart';

class ProfileApi {
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
