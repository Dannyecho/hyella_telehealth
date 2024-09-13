import 'package:hyella_telehealth/core/constants/app_constants.dart';
import 'package:hyella_telehealth/core/utils/app_util.dart';
import 'package:hyella_telehealth/core/utils/http_util.dart';
import 'package:hyella_telehealth/data/repository/entities/contact_entity.dart';

class MsgContactApi {
  Future<MsgContactListResponse?> getContactList() async {
    try {
      String publicKey = AppUtil.generateMd5ForApiAuth("app_list_of_doctors");
      String uri =
          "&nwp_request=msg_contact_list&token=${AppConstants.token}&public_key=$publicKey";
      var response = await HttpUtil().post(uri);
      return MsgContactListResponse.fromJson(response);
    } catch (e) {
      return MsgContactListResponse.fromJson({
        'type': 0,
        'msg': 'Encountered Error',
        'data': null,
      });
    }
  }
}
