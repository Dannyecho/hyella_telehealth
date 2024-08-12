import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:hyella_telehealth/core/constants/app_constants.dart';
import 'package:hyella_telehealth/core/global.dart';

class HttpUtil {
  late final Dio _dio;
  late final BaseOptions base_options;
  late final BaseOptions clientID;
  static HttpUtil _instance = HttpUtil._Internal();
  factory HttpUtil() {
    return _instance;
  }

  HttpUtil._Internal() {
    BaseOptions baseOptions = BaseOptions(
      baseUrl: AppConstants.BASE_URL,
      method: 'post',
      contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
      responseType: ResponseType.json,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
      headers: {},
    );

    _dio = Dio(baseOptions);
    _instance = this;
  }

  set setBaseUrl(String url) {
    _dio.options.baseUrl = url;
  }

  set setClientID(String id) {
    _dio.options.baseUrl = id;
  }

  post(path,
      {dynamic data,
      Map<String, dynamic>? queryParameters,
      Options? options}) async {
    Options requestOptions = options ?? Options();
    requestOptions.headers = requestOptions.headers ?? {};
    var authorization = getAuthorizationHeader();

    if (authorization != null) {
      requestOptions.headers!.addAll(authorization);
    }

    Response response = await _dio.post(
      path,
      data: data,
      queryParameters: queryParameters,
    );

    // print(response.data);
    return parseFormData(response.data);
  }

  static parseFormData(String formDataString) {
    final parsed = jsonDecode(formDataString);
    return parsed;
  }

  Map<String, dynamic>? getAuthorizationHeader() {
    var accessToken = Global.storageService.getUserToken();
    if (accessToken != null) {
      return {'Authorization': 'Bearer $accessToken'};
    }
    return null;
  }
}
