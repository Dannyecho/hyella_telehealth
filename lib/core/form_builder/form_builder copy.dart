import 'package:flutter/material.dart';
import 'package:hyella_telehealth/core/form_builder/form_widgets/checkbox_field_builder.dart';
import 'package:hyella_telehealth/core/form_builder/form_widgets/radio_field_builder.dart';
import 'package:hyella_telehealth/core/form_builder/form_widgets/text_input_field_builder.dart';
import 'package:hyella_telehealth/data/repository/entities/endpoint_entity.dart';

final class FormBuilder extends StatefulWidget {
  final EndpointForms formObject;
  BuildContext context;
  void Function(Map<String, dynamic> formData) onSubmit;

  FormBuilder(
    this.context, {
    required this.formObject,
    required this.onSubmit,
  });

  @override
  State<FormBuilder> createState() => _FormBuilderState();
}

class _FormBuilderState extends State<FormBuilder> {
  late final List formFields;
  final formKey = GlobalKey<FormState>();

  List<Widget>? beforeFormFieldsWidget;

  List<Widget>? afterFormFieldsWidgets;

  @override
  void initState() {
    super.initState();
    initFields();
  }

  void initFields() {
    formFields = buildFieldTypes();
  }

  List<Widget?> buildFieldTypes() {
    return widget.formObject.fields!.map((field) {
      switch (field!.formField) {
        case "text":
        case "textarea":
        case "decimal":
        case "number":
        case "password":
        case "email":
          return TextInputFieldBuilder(
            key: field.name!,
            field: field,
            context: context,
          ).widget;
        case "checkbox":
          return CheckboxFieldBuilder(
            key: field.name!,
            field: field,
            context: context,
          ).widget;

        case "radio":
          return RadioFieldBuilder(
                  key: field.name!, context: context, field: field)
              .widget;
        case "date-5":
        case "select":
        case "multi-select":
        case "date-5time":
        case "time":
        case "tel":
        case "email":
        case "calculated":
        case "file":
        case "picture":
        case "html":
        case "color":
        case "old-password":
        case 'confirm_password':
        default:
      }
    }).toList();
  }

  List<Widget>? get fieldWidgets {
    if (formFields.isNotEmpty) {
      return [
        for (var field in formFields)
          if (field != null) field.widget,
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
    return Form(
      key: formKey,
      child: Column(
        children: [
          ...?beforeFormFieldsWidget,
          ...?fieldWidgets,
          ...?afterFormFieldsWidgets,
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          ...widget.formObject.fields!.map((field) {
            switch (field!.formField) {
              case "text":
              case "textarea":
              case "decimal":
              case "number":
              case "password":
              case "email":
                return TextInputFieldBuilder(
                        key: field.name!, field: field, context: context)
                    .widget;
              case 'radio':
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(field.fieldLabel!),
                    ...field.formFieldOptions!.map((option) {
                      return RadioListTile(
                        title: Text(option!.value),
                        value: option,
                        groupValue: null, // Replace with actual selected value
                        onChanged: (value) {
                          setState(() {});
                          // Handle radio button change
                        },
                      );
                    }).toList(),
                  ],
                );
              default:
                return Text('Unsupported field type: ${field.formField}');
            }
          }).toList(),
        ],
      ),
    );
  }
}
