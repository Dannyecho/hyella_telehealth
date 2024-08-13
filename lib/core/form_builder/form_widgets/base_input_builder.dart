import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hyella_telehealth/data/repository/entities/endpoint_entity.dart';

abstract class BaseInputBuilder {
  BuildContext context;
  EndpointFormFields field;
  String key;
  dynamic value;
  dynamic initialValue;

  BaseInputBuilder({
    required this.context,
    required this.key,
    required this.field,
    this.initialValue,
  });
  Widget get widget;
}
