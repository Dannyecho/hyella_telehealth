import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hyella_telehealth/core/constants/app_colors2.dart';
import 'package:hyella_telehealth/core/form_builder/form_widgets/checkbox_field_builder.dart';
import 'package:hyella_telehealth/core/form_builder/form_widgets/radio_field_builder.dart';
import 'package:hyella_telehealth/core/form_builder/form_widgets/text_input_field_builder.dart';
import 'package:hyella_telehealth/data/repository/entities/endpoint_entity.dart';
import 'package:hyella_telehealth/logic/bloc/form_builder_bloc.dart';

final class FormBuilder {
  final EndpointForms formObject;
  BuildContext context;
  late final List<Widget?> formFields;
  final formKey = GlobalKey<FormState>();
  List<Widget>? beforeFormFieldsWidget;
  List<Widget>? afterFormFieldsWidgets;
  void Function(String url, Map<String, dynamic> formData) onSubmit;
  Map<String, dynamic> initialValues;

  FormBuilder(this.context,
      {required this.formObject,
      required this.onSubmit,
      this.initialValues = const {}}) {
    Map<String, EndpointFormFields> formFieldData = {};
    for (var field in formObject.fields!) {
      formFieldData[field!.name!] = field;
    }

    context
        .read<FormBuilderBloc>()
        .add(RegisterFormField(formData: formFieldData));
    if (initialValues.isNotEmpty) {
      initialValues.entries.map((entry) {
        if (formFieldData.containsKey(entry.key)) {
          context.read<FormBuilderBloc>().state.formData[entry.key]?.value =
              entry.value;
        }
      });
    }
    initFields();
  }

  void initFields() {
    formFields = buildFieldTypes();
  }

  List<Widget> buildFieldTypes() {
    return formObject.fields!.map((field) {
      switch (field?.formField) {
        case "text":
        case "textarea":
        case "decimal":
        case "number":
        case "password":
        case "email":
        case "old-password":
        case 'confirm_password':
          return TextInputFieldBuilder(
            key: field!.name!,
            field: field,
            context: context,
            initialValue: initialValues[field.name!],
          ).widget;
        case "checkbox":
          return CheckboxFieldBuilder(
            key: field!.name!,
            field: field,
            context: context,
            initialValue: initialValues[field.name!],
          ).widget;

        case "radio":
          return RadioFieldBuilder(
            key: field!.name!,
            context: context,
            field: field,
            initialValue: initialValues[field.name!],
          ).widget;
        case "date-5":
        case "select":
        case "multi-select":
        case "date-5time":
        case "time":
        case "tel":
        case "calculated":
        case "file":
        case "picture":
        case "html":
        case "color":
        default:
          return const Text("Unsupported form field");
      }
    }).toList();
  }

  Map<String, dynamic>? get formData {
    var cachedData = context.read<FormBuilderBloc>().state.formData;
    Map<String, dynamic> returnData = {};
    for (var cd in cachedData.entries) {
      if (cd.value.value != null) {
        returnData[cd.key] = cd.value.value;
      }
    }

    return returnData;
  }

  void beforeFormFields(List<Widget> widgets) {
    beforeFormFieldsWidget = widgets;
  }

  void afterFormFields(List<Widget> widgets) {
    afterFormFieldsWidgets = widgets;
  }

  Widget buildForm(context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          ...?beforeFormFieldsWidget,
          // ...?fieldWidgets,
          ...buildFieldTypes(),
          ...?afterFormFieldsWidgets,
          InkWell(
            onTap: () {
              var form = formKey.currentState!;
              if (form.validate()) {
                // form.save();
                var url =
                    "action=${formObject.action}&nwp_request=${formObject.action}";
                // print("validated");
                onSubmit(url, formData!);
              }
            },
            child: Container(
              alignment: Alignment.center,
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.only(top: 20),
              decoration: BoxDecoration(
                color: AppColors2.color1,
                borderRadius: const BorderRadius.all(Radius.circular(16)),
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
