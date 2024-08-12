import 'package:flutter/material.dart';
import 'package:hyella_telehealth/core/constants/app_colors.dart';
import 'package:hyella_telehealth/core/form_builder/form_widgets/base_input_builder.dart';
import 'package:hyella_telehealth/core/form_builder/form_widgets/checkbox_field_builder.dart';
import 'package:hyella_telehealth/core/form_builder/form_widgets/text_input_field_builder.dart';
import 'package:hyella_telehealth/data/repository/entities/endpoint_entity.dart';

final class FormBuilder {
  final EndpointForms formObject;
  BuildContext context;
  late final List<BaseInputBuilder?> formFields;
  final formKey = GlobalKey<FormState>();
  List<Widget>? beforeFormFieldsWidget;
  List<Widget>? afterFormFieldsWidgets;
  void Function(Map<String, dynamic> formData) onSubmit;

  FormBuilder(
    this.context, {
    required this.formObject,
    required this.onSubmit,
  }) {
    initFields();
  }

  void initFields() {
    formFields = buildFieldTypes();
  }

  List<BaseInputBuilder?> buildFieldTypes() {
    final fields = formObject.fields!;

    if (fields.isNotEmpty) {
      var returned = List.generate(formObject.fields!.length, (i) {
        var e = fields[i];

        if (e?.formField != null && e?.name != null) {
          switch (e!.formField) {
            case "text":
            case "textarea":
            case "password":
            case "email":
              return TextInputFieldBuilder(
                key: e.name!,
                field: e,
              );
            case "checkbox":
              return CheckboxFieldBuilder(key: e.name!, field: e);
            case "date-5":
            case "select":
            case "multi-select":
            case "date-5time":
            case "time":
            case "tel":
            case "email":
            case "decimal":
            case "number":
            case "calculated":
            case "file":
            case "picture":
            case "radio":
            case "html":
            case "color":
            case "old-password":
            case 'confirm_password':
            default:
          }
        }
      });
      return returned;
    }
    return [];
  }

  List<Widget>? get fieldWidgets {
    if (formFields.isNotEmpty) {
      return [
        for (var field in formFields) field!.widget,
      ];
    }
    return null;
  }

  Map<String, dynamic>? get formData {
    var form = formKey.currentState!;
    if (form.validate()) {
      form.save();
    }

    return {for (var field in formFields) field!.key: field.value};
  }

  void beforeFormFields(List<Widget> widgets) {
    beforeFormFieldsWidget = widgets;
  }

  void afterFormFields(List<Widget> widgets) {
    afterFormFieldsWidgets = widgets;
  }

  Widget buildForm() {
    for (var field in formFields) {
      print(field?.widget);
    }
    return Form(
      key: formKey,
      child: Column(
        children: [
          ...?beforeFormFieldsWidget,
          ...?fieldWidgets,
          ...?afterFormFieldsWidgets,
          InkWell(
            onTap: () {
              var form = formKey.currentState!;
              if (form.validate()) {
                form.save();
                onSubmit(formData!);
              }
            },
            child: Container(
              alignment: Alignment.center,
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.only(top: 60),
              decoration: const BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
              child: Text(
                formObject.title!,
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
    );
  }
}
