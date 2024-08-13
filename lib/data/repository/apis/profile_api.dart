import 'dart:io';

import 'package:hyella_telehealth/core/constants/app_constants.dart';
import 'package:hyella_telehealth/core/utils/app_util.dart';
import 'package:hyella_telehealth/core/utils/http_util.dart';
import 'package:hyella_telehealth/data/repository/entities/app_http_response.dart';

class ProfileApi {
  Future<AppHttpResponse> updateProfie(url, data) async {
    var url = 'action=${data?['action']}&nwp_request=${data?['nwp_request']}';
    String token = AppConstants.token;

    url += '&token=$token&public_key=${AppUtil.generateMd5(url)}';
    var response = await HttpUtil().post(url, data: data);
    return AppHttpResponse.fromMap(response);
  }
}
