import 'package:hyella_telehealth/core/utils/app_util.dart';
import 'package:hyella_telehealth/core/utils/http_util.dart';

class ScheduleApi {
  Future<Map<String, dynamic>> fetchUpComingSchedules() async {
    try {
      String publicKey = AppUtil.generateMd5ForApiAuth("app_l_upcoming");
      String uri = "&nwp_request=app_l_upcoming&public_key=$publicKey";
      var response = await HttpUtil().post(uri);
      return response;
    } catch (e) {
      return {'type': 0, 'msg': 'Error fetching upcoming schedules'};
    }
  }

  Future<Map<String, dynamic>> fetchCompletedSchedules() async {
    try {
      String publicKey = AppUtil.generateMd5ForApiAuth("app_l_upcoming");
      String uri = "&nwp_request=app_l_completed&public_key=$publicKey";
      var response = await HttpUtil().post(uri) as Map<String, dynamic>;
      return response;
    } catch (e) {
      return {'type': 0, 'msg': 'Error fetching upcoming schedules'};
    }
  }

  Future<Map<String, dynamic>> fetchCancelledSchedules() async {
    try {
      String publicKey = AppUtil.generateMd5ForApiAuth("app_l_upcoming");
      String uri = "&nwp_request=app_l_cancelled&public_key=$publicKey";
      var response = await HttpUtil().post(uri) as Map<String, dynamic>;
      return response;
    } catch (e) {
      return {'type': 0, 'msg': 'Error fetching upcoming schedules'};
    }
  }

  Future<Map<String, dynamic>> cancelAppointment(String appRef) async {
    try {
      String publicKey = AppUtil.generateMd5ForApiAuth("app_list_cancel");

      String uri =
          "&nwp_request=app_list_cancel&public_key=$publicKey&appointment_ref=$appRef";

      var response = await HttpUtil().post(uri);
      return response;
    } catch (e) {
      return {
        'type': 0,
        'msg': 'Error occured on cancelling your appointment',
      };
    }
  }
}
