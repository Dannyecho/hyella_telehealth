import 'package:hyella_telehealth/core/utils/app_util.dart';
import 'package:hyella_telehealth/core/utils/http_util.dart';
import 'package:hyella_telehealth/data/repository/entities/revenue_response_entity.dart';

class RevenueApi {
  Future<RevenueResponseEntity> fetchRevenue() async {
    String publicKey = AppUtil.generateMd5ForApiAuth("card_menu");
    // String sid = userDetails.sessionId!;
    String uri = "nwp_request=apps_revenue_gen&public_key=$publicKey";

    try {
      var response = await HttpUtil().post(uri) as Map<String, dynamic>;
      return RevenueResponseEntity.fromJson(response);
    } catch (e) {
      return RevenueResponseEntity(
        type: 0,
        msg: 'Error on fetching revenue',
        data: null,
      );
    }
  }
}
