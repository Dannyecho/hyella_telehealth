import 'dart:ui';

import 'package:hyella_telehealth/core/utils/app_util.dart';
import 'package:hyella_telehealth/data/repository/entities/endpoint_entity.dart';

class AppColors2 {
  static final AppColors2 _instance = AppColors2._internal();
  AppColors2._internal();

  late Color _color1 = AppUtil.fromHex('#0979ba');
  late final Color _color2;
  late final Color _color3;
  late final Color _color4;
  late final Color _color5;
  late final Color _color6;

  static AppColors2 get instance => _instance;

  void registerInstance(EndPointEntityDataClient client) {
    _color1 = AppUtil.fromHex(client.color1!);
    _color2 = AppUtil.fromHex(client.color2!);
    _color3 = AppUtil.fromHex(client.color3!);
    _color4 = AppUtil.fromHex(client.color4!);
    _color5 = AppUtil.fromHex(client.color5!);
    _color6 = AppUtil.fromHex(client.color6!);
  }

  static get color1 {
    return _instance._color1;
  }

  static get color2 {
    return _instance._color2;
  }

  static get color3 {
    return _instance._color3;
  }

  static get color4 {
    return _instance._color4;
  }

  static get color5 {
    return _instance._color5;
  }

  static get color6 {
    return _instance._color6;
  }
}
