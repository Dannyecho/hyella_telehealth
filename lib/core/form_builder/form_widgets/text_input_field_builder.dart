import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hyella_telehealth/core/constants/app_colors.dart';
import 'package:hyella_telehealth/core/form_builder/form_widgets/base_input_builder.dart';
import 'package:hyella_telehealth/data/repository/entities/endpoint_entity.dart';

class TextInputFieldBuilder extends BaseInputBuilder {
  EndpointFormFields field;
  String key;
  dynamic value = "";
  void Function()? onUpdate;
  late final validator;

  TextInputFieldBuilder({
    required String this.key,
    required this.field,
    this.onUpdate,
  }) : super(key: key, field: field) {
    switch (field.formField) {
      case 'email':
        validator = FormBuilderValidators.compose(
            [FormBuilderValidators.required(), FormBuilderValidators.email()]);
        break;
      case 'password':
        validator = FormBuilderValidators.compose([
          FormBuilderValidators.required(),
          FormBuilderValidators.password(
            minLength: 6,
            minUppercaseCount: 0,
            minSpecialCharCount: 0,
          ),
        ]);
        break;
      default:
        validator = FormBuilderValidators.required();
        break;
    }
  }

  Widget get widget {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: TextFormField(
        autocorrect: false,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          labelText:
              field.fieldLabel! + ((field.requiredField! > 0) ? "*" : ''),
          labelStyle: const TextStyle(color: AppColors.lightText2),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.lightText2),
              borderRadius: BorderRadius.all(Radius.circular(12))),
        ),
        validator: validator,
        onSaved: (str) => value = str!,
        obscureText: field.formField == 'password',
      ),
    );
  }
}
