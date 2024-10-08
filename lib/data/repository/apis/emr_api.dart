import 'package:hyella_telehealth/core/utils/app_util.dart';
import 'package:hyella_telehealth/core/utils/http_util.dart';

class EmrApi {
  Future<Map<String, dynamic>> getEmrOptions(key) async {
    String publicKey = AppUtil.generateMd5ForApiAuth("card_menu");
    // String sid = userDetails.sessionId!;
    String uri = "nwp_request=card_menu&id=$key&public_key=$publicKey";

    try {
      var response = await HttpUtil().post(uri) as Map<String, dynamic>;
      return response;
    } catch (e) {
      return {'type': 0, 'msg': "Error on get your EMR details"};
    }
  }

  Future<Map<String, dynamic>> getLabResults() async {
    String publicKey = AppUtil.generateMd5ForApiAuth("card_menu");
    // String sid = userDetails.sessionId!;
    String uri = "nwp_request=card_menu&&id=myemr&public_key=$publicKey";

    try {
      var response = await HttpUtil().post(uri) as Map<String, dynamic>;
      return response;
    } catch (e) {
      return {'type': 0, 'msg': "Error on fetching lab results"};
    }
  }
}
