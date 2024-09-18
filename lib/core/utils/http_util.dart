import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:hyella_telehealth/core/constants/app_constants.dart';
import 'package:hyella_telehealth/core/global.dart';

class HttpUtil {
  late final Dio _dio;
  late final BaseOptions base_options;
  late final String clientID;
  // late final String userID;
  // late final BaseOptions clientID;
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

  get getBaseUrl {
    _dio.options.baseUrl;
  }

  set setClientID(String id) {
    _dio.options.baseUrl += '&cid=$id';
    clientID = id;
  }

  post(path,
      {dynamic data,
      Map<String, dynamic>? queryParameters,
      Options? options}) async {
    Options requestOptions = options ?? Options();
    requestOptions.headers = requestOptions.headers ?? {};
    var authorization = getAuthorizationHeader();
    String? pidParam = '&pid=';
    String? cidParam = '&cid=';
    pidParam += Global.storageService.getUserToken() ?? '';
    cidParam += Global.storageService.getClientId() ?? '';

    if (authorization != null) {
      requestOptions.headers!.addAll(authorization);
    }

    // print(path + pidParam + cidParam + '--------------Path');
    Response response = await _dio.post(
      path + pidParam + cidParam,
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

  sendFiles(path, Map<String, dynamic> files,
      {Map<String, dynamic>? queryParameters, Options? options}) async {
    Options requestOptions = options ?? Options();
    requestOptions.headers = requestOptions.headers ?? {};
    var authorization = getAuthorizationHeader();
    String? pidParam = '&pid=';
    String? cidParam = '&cid=';
    pidParam += Global.storageService.getUserToken() ?? '';
    cidParam += Global.storageService.getClientId() ?? '';
    List formFiles = [];

    files.forEach((key, value) {
      formFiles.add(MultipartFile.fromFile(value, filename: key));
    });

    if (authorization != null) {
      requestOptions.headers!.addAll(authorization);
    }

    if (queryParameters != null) {
      queryParameters['files'] = files;
    } else {
      queryParameters = {'files': files};
    }

    final formData = FormData.fromMap(queryParameters);

    final Response response = await _dio.post(
      path + pidParam + cidParam,
      data: formData,
      queryParameters: queryParameters,
    );

    return parseFormData(response.data);
  }
}
