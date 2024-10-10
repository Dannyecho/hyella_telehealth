import 'package:hyella_telehealth/core/global.dart';
import 'package:hyella_telehealth/core/utils/app_util.dart';
import 'package:hyella_telehealth/core/utils/http_util.dart';
import 'package:hyella_telehealth/data/repository/entities/contact_entity.dart';
import 'package:hyella_telehealth/data/repository/entities/login_response_entity.dart';

class MsgContactApi {
  bool isDoctor = Global.storageService.getAppUser()!.isStaff == 1;
  Future<Map<String, dynamic>> setChatToRead(
      String chatKey, String receiverId) async {
    String publicKey = AppUtil.generateMd5ForApiAuth('msg_read');

    String uri = isDoctor
        ? "&nwp_request=msgs_read&patient_id=$receiverId"
        : "&nwp_request=msg_read&doctor_id=$receiverId";

    uri += "&public_key=$publicKey&chat_key=$chatKey";
    print(uri);

    return await HttpUtil().post(uri);
    // return MsgContactListResponse.fromJson(response);
  }

  Future<MsgContactListResponse?> getContactList() async {
    try {
      User? user = Global.storageService.getAppUser();
      String requestType = 'msg_contact_list';
      if (user!.isStaff == 1) {
        requestType = 'msgs_contact_list';
      }

      String publicKey = AppUtil.generateMd5ForApiAuth("app_list_of_doctors");
      String uri = "&nwp_request=$requestType&public_key=$publicKey";
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
