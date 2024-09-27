import 'dart:convert';

import 'package:hyella_telehealth/core/constants/app_constants.dart';
import 'package:hyella_telehealth/core/global.dart';
import 'package:hyella_telehealth/core/utils/http_util.dart';
import 'package:hyella_telehealth/data/repository/entities/endpoint_entity.dart';

class InitializeAppApi {
  late final Uri initialRequestUrl;
  static const String requestType = 'initialize_ss';
  static const String hospitalId = '100';
  static const String appSecretKey = '55b6b3ffb7889de4d24d9761fc773f81';
  static const String appName = 'com.example.hyella_telehealth';

  InitializeAppApi() {
    initialRequestUrl = Uri.parse(
      "https://webapp.hyella.com.ng/demo/emr-v1.3/engine/api/?nwp_request=$requestType&hospital_id=$hospitalId&app_secret=$appSecretKey&app_name=$appName",
    );
  }

  Future<EndPointEntity> fetchAppResource() async {
    var response = await HttpUtil().post(initialRequestUrl.toString());
    if (response is Map &&
        response.containsKey('data') &&
        response['data'] != null) {
      Global.storageService
          .setString(AppConstants.ENDPOINT_ENTITY_KEY, jsonEncode(response));
    }
    return EndPointEntity.fromJson(response);
  }
}
