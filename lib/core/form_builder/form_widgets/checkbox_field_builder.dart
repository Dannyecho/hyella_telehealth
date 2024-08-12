import 'package:flutter/material.dart';
import 'package:hyella_telehealth/core/form_builder/form_widgets/base_input_builder.dart';
import 'package:hyella_telehealth/data/repository/entities/endpoint_entity.dart';

class CheckboxFieldBuilder extends BaseInputBuilder {
  dynamic value = false;
  String key;
  EndpointFormFields field;

  void Function()? onUpdate;
  late final validator;

  CheckboxFieldBuilder({
    required this.key,
    required this.field,
    this.onUpdate,
  }) : super(key: key, field: field);

  @override
  Widget get widget => Container(
        margin: const EdgeInsets.only(bottom: 20),
        child: CheckboxListTile(
          title: Text(field.fieldLabel!),
          value: value,
          onChanged: (value) => value = value,
        ),
      );
}
