import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hyella_telehealth/core/constants/app_colors.dart';
import 'package:hyella_telehealth/core/constants/app_colors2.dart';
import 'package:hyella_telehealth/core/form_builder/form_widgets/base_input_builder.dart';
import 'package:hyella_telehealth/data/repository/entities/endpoint_entity.dart';
import 'package:hyella_telehealth/logic/bloc/form_builder_bloc.dart';

class TextInputFieldBuilder extends BaseInputBuilder {
  BuildContext context;
  EndpointFormFields field;
  String key;
  dynamic value = "";
  dynamic initialValue = "";
  bool obscure = false;
  void Function()? onUpdate;
  dynamic validator = (value) {
    return null;
  };
  late TextInputType textInputType = TextInputType.none;

  TextInputFieldBuilder({
    required String this.key,
    required this.context,
    required this.field,
    this.onUpdate,
    this.initialValue,
  }) : super(
          key: key,
          field: field,
          context: context,
        ) {
    switch (field.formField) {
      case 'email':
        textInputType = TextInputType.emailAddress;
        validator = FormBuilderValidators.compose(
            [FormBuilderValidators.required(), FormBuilderValidators.email()]);
        break;
      case 'password':
      case 'confirm_password':
        textInputType = TextInputType.text;
        validator = FormBuilderValidators.compose([
          FormBuilderValidators.required(),
          FormBuilderValidators.password(
            minLength: 6,
            minUppercaseCount: 0,
            minSpecialCharCount: 0,
          ),
        ]);
        obscure = true;
        break;
      case 'decimal':
      case 'number':
        textInputType = TextInputType.number;
        if (field.requiredField != null && field.requiredField! > 0) {
          validator = FormBuilderValidators.compose([
            FormBuilderValidators.required(),
          ]);
        }
        break;
      case 'textarea':
        textInputType = TextInputType.multiline;
        if (field.requiredField != null && field.requiredField! > 0) {
          validator = FormBuilderValidators.compose([
            FormBuilderValidators.required(),
          ]);
        }
        break;
      default:
        textInputType = TextInputType.text;
        if (field.requiredField != null && field.requiredField! > 0) {
          validator = FormBuilderValidators.compose([
            FormBuilderValidators.required(),
          ]);
        }
        break;
    }
  }

  Widget get widget {
    return Container(
      margin: const EdgeInsets.only(bottom: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            keyboardType: textInputType,
            autocorrect: false,
            initialValue: initialValue,
            // context.read<FormBuilderBloc>().state.formData[key]?.value ?? '',
            autovalidateMode: AutovalidateMode.onUserInteraction,
            inputFormatters: [
              if (field.formField == 'decimal')
                FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
            ],
            decoration: InputDecoration(
              labelText: field.fieldLabel! +
                  ((field.requiredField != null && field.requiredField! > 0)
                      ? "*"
                      : ''),
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
            // onSaved: (str) => value = str!,
            onChanged: (value) {
              context
                  .read<FormBuilderBloc>()
                  .add(SetField(key: key, value: value.toString()));
            },
            onSaved: (str) {
              value = str;
              print("String on save = $str");
              /* context
                  .read<FormBuilderBloc>()
                  .add(SetField(key: key, value: str.toString())); */
            },
            obscureText: obscure,
          ),
          field.note == null || field.note!.isEmpty
              ? const SizedBox()
              : Text(
                  field.note!,
                  style: GoogleFonts.robotoSlab(
                    fontSize: 10,
                    color: AppColors2.color1,
                  ),
                ),
        ],
      ),
    );
  }
}
