// ignore_for_file: constant_identifier_names, non_constant_identifier_names

import 'dart:math';

class AppConstants {
  static const String STORAGE_DEVICE_FOR_THE_FIRST_TIME = 'device_first_open';
  static const String STORAGE_USER_PROFILE_KEY = 'user_profile_key';
  static const String STORAGE_USER_TOKEN_KEY = 'user_token_key';
  static const String STORAGE_USER_IS_PATIENT = 'is_patient';
  static const String STORAGE_APP_DATA = 'app_data';
  static const String SERVER_API_FILES_URL =
      'http://172.20.10.5/fimi/public/files/';
  static const String SERVER_API_URL = 'http://172.20.10.5/';
  static const String BASE_URL = 'https://webapp.hyella.com.ng/';
  static String token = (Random().nextInt(90000000) + 100000000).toString();
}
