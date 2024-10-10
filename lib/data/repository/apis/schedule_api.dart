import 'package:hyella_telehealth/core/global.dart';
import 'package:hyella_telehealth/core/utils/app_util.dart';
import 'package:hyella_telehealth/core/utils/http_util.dart';
import 'package:hyella_telehealth/data/repository/entities/login_response_entity.dart';

class ScheduleApi {
  Future<Map<String, dynamic>> fetchUpComingSchedules() async {
    try {
      User? user = Global.storageService.getAppUser();
      String requestType = 'app_l_upcoming';
      if (user!.isStaff == 1) {
        requestType = 'app_ls_upcoming';
      }
      String publicKey = AppUtil.generateMd5ForApiAuth("app_l_upcoming");
      String uri = "&nwp_request=$requestType&public_key=$publicKey";
      var response = await HttpUtil().post(uri);
      return response;
    } catch (e) {
      return {'type': 0, 'msg': 'Error fetching upcoming schedules'};
    }
  }

  Future<Map<String, dynamic>> fetchCompletedSchedules() async {
    try {
      User? user = Global.storageService.getAppUser();
      String requestType = 'app_l_completed';
      if (user!.isStaff == 1) {
        requestType = 'app_ls_completed';
      }
      String publicKey = AppUtil.generateMd5ForApiAuth("app_l_upcoming");
      String uri = "&nwp_request=$requestType&public_key=$publicKey";
      var response = await HttpUtil().post(uri) as Map<String, dynamic>;
      return response;
    } catch (e) {
      return {'type': 0, 'msg': 'Error fetching upcoming schedules'};
    }
  }

  Future<Map<String, dynamic>> fetchCancelledSchedules() async {
    try {
      User? user = Global.storageService.getAppUser();
      String requestType = 'app_l_cancelled';
      if (user!.isStaff == 1) {
        requestType = 'app_ls_cancelled';
      }

      String publicKey = AppUtil.generateMd5ForApiAuth(requestType);
      String uri = "&nwp_request=$requestType&public_key=$publicKey";
      var response = await HttpUtil().post(uri) as Map<String, dynamic>;
      return response;
    } catch (e) {
      return {'type': 0, 'msg': 'Error fetching upcoming schedules'};
    }
  }

  Future<Map<String, dynamic>> cancelAppointment(String appRef) async {
    try {
      User? user = Global.storageService.getAppUser();
      String requestType = 'app_list_cancel';
      if (user!.isStaff == 1) {
        requestType = 'apps_list_cancel';
      }

      String publicKey = AppUtil.generateMd5ForApiAuth("app_list_cancel");

      String uri =
          "&nwp_request=$requestType&public_key=$publicKey&appointment_ref=$appRef";

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
