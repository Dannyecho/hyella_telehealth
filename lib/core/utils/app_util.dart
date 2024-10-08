import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:crypto/crypto.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:hyella_telehealth/core/constants/app_constants.dart';
import 'package:hyella_telehealth/core/global.dart';
import 'package:hyella_telehealth/data/repository/entities/chat_entity.dart';
import 'package:hyella_telehealth/data/repository/entities/endpoint_entity.dart';

class AppUtil {
  static double deviceWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static String generateMd5(String input) {
    return md5.convert(utf8.encode(input)).toString();
  }

  static String generateMd5ForApiAuth(String nwpRequest) {
    return md5
        .convert(utf8.encode("${AppConstants.token}$nwpRequest"))
        .toString();
  }

  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  static Future<String?> getDeviceId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.id; // unique ID on Android
    }
    return null;
  }

  static String getGreeting() {
    final now = DateTime.now();
    final hour = now.hour;

    if (hour >= 0 && hour < 12) {
      return 'Good morning';
    } else if (hour >= 12 && hour < 16) {
      return 'Good afternoon';
    } else {
      return 'Good evening';
    }
  }

  static String capitalizeEachWord(String input) {
    return input.split(' ').map((word) => word.capitalize()).join(' ');
  }

  static String stripGetChat(String input, String key) {
    input = input.replaceAll(key, '');
    for (var delimitter in ChatDelimiters.all) {
      input = input.replaceAll(delimitter.toString(), '');
    }

    return input.trim();
  }

  static String getHashKey(token) {
    EndPointEntityData? endpoint = Global.storageService.getEndpoints();
    String? clientID = Global.storageService.getClientId();
    if (clientID == null || endpoint == null) {
      return '';
    }

    return generateMd5(clientID + endpoint.privateKey! + token);
  }
}

extension StringExtension on String {
  String capitalize() {
    if (isEmpty) return this;
    return this[0].toUpperCase() + substring(1);
  }
}
