import 'package:flutter/material.dart';
import 'package:hyella_telehealth/data/repository/entities/endpoint_entity.dart';

abstract class BaseInputBuilder {
  EndpointFormFields field;
  String key;
  dynamic value;
  void Function()? onUpdate;

  BaseInputBuilder({
    required this.key,
    required this.field,
    this.onUpdate,
  });
  Widget get widget;
}
