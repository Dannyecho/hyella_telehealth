import 'dart:convert';

import 'package:hyella_telehealth/core/constants/app_constants.dart';
import 'package:hyella_telehealth/data/repository/entities/app_settings_entity.dart';
import 'package:hyella_telehealth/data/repository/entities/endpoint_entity.dart';
import 'package:hyella_telehealth/data/repository/entities/login_response_entity.dart';
import 'package:hyella_telehealth/presentation/widgets/toast_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  // ignore: unused_field
  late final SharedPreferencesWithCache _prefs;
  Future<StorageService> init() async {
    _prefs = await SharedPreferencesWithCache.create(
      cacheOptions: const SharedPreferencesWithCacheOptions(),
    );

    return this;
  }

  Future<void> setBool(key, value) async {
    return await _prefs.setBool(key, value);
  }

  Future<void> setString(key, String value) async {
    return await _prefs.setString(key, value);
  }

  bool getBool(key) {
    return _prefs.getBool(key) ?? false;
  }

  String? getString(key) {
    return _prefs.getString(key);
  }

  bool getIsUserLoggedIn() {
    return _prefs.getString(AppConstants.STORAGE_USER_TOKEN_KEY) == null
        ? false
        : true;
  }

  EndPointEntityDataClient? getAppClient() {
    try {
      EndPointEntityData? entityData = EndPointEntityData.fromJson(
          jsonDecode(_prefs.getString(AppConstants.ENDPOINT_ENTITY_KEY)!));
      return entityData.client;
    } catch (e) {
      print("Unable to retieve app client");
    }
    return null;
  }

  EndPointEntityData? getEndpoints() {
    try {
      var endpoint = _prefs.getString(AppConstants.ENDPOINT_ENTITY_KEY);
      if (endpoint == null) {
        print("Endpoint is null----------------------------------");
        return null;
      }
      var entity = EndPointEntity.fromJson(jsonDecode(endpoint));
      return entity.data;
    } catch (e) {
      print("Unable to retieve app enpoints------------------");
    }
    return null;
  }

  Data? getAppData() {
    try {
      String? data = _prefs.getString(AppConstants.STORAGE_APP_DATA);
      if (data != null) {
        return Data.fromJson(jsonDecode(data));
      }
      return null;
    } catch (e) {
      toastInfo(msg: "Error Retrieving user data");
    }
    return null;
  }

  User? getAppUser() {
    try {
      String? data = _prefs.getString(AppConstants.STORAGE_USER_PROFILE_KEY);
      if (data != null) {
        return User.fromJson(jsonDecode(data));
      }
      return null;
    } catch (e) {
      toastInfo(msg: "Error Retrieving user data");
    }
    return null;
  }

  /* UserItem getUserItem() {
    final String? profileOffline =
        _prefs.getString(AppConstants.STORAGE_USER_PROFILE_KEY);
    if (profileOffline != null) {
      return UserItem.fromJson(jsonDecode(profileOffline));
    }
    return UserItem();
  } */

  String? getUserToken() {
    return _prefs.getString(AppConstants.STORAGE_USER_TOKEN_KEY);
  }

  String? getClientId() {
    return _prefs.getString(AppConstants.STORAGE_CLIENT_ID);
  }

  Future<void> remove(String key) {
    return _prefs.remove(key);
  }

  AppSettingsEntity? getAppSettings() {
    String? settings = _prefs.getString(AppConstants.STORAGE_APP_SETTINGS);
    if (settings != null) {
      return AppSettingsEntity.fromJson(settings);
    }
    return null;
  }
}
