import 'package:hyella_telehealth/core/form_builder/input_types/base_input_type.dart';

class MultiSelectInputType extends BaseInputType {
  final String? name;
  final String? fieldLabel;
  final String? formField;
  final int? requiredField;
  final String? note;
  final int? min;
  final int? max;
  final Map<String, dynamic>? formFieldOptions;
  List<String>? response;
  final String? validationMessage;

  MultiSelectInputType(
      {this.name,
      this.fieldLabel,
      this.formField,
      this.requiredField,
      this.note,
      this.min,
      this.max,
      this.validationMessage,
      this.formFieldOptions,
      this.response});

  MultiSelectInputType.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String?,
        fieldLabel = json['field_label'] as String?,
        formField = json['form_field'] as String?,
        requiredField = json['required_field'] as int?,
        note = json['note'] as String?,
        min = json['min'] as int?,
        max = json['max'] as int?,
        response = [],
        formFieldOptions =
            (json['form_field_options'] as Map<String, dynamic>?) != null
                ? json['form_field_options'] as Map<String, dynamic>
                : null,
        validationMessage = json['validation_message'] as String?;

  Map<String, dynamic> toJson() => {
        'validation_message': validationMessage,
        'name': name,
        'field_label': fieldLabel,
        'form_field': formField,
        'required_field': requiredField,
        'note': note,
        'min': min,
        'max': max,
        'form_field_options': formFieldOptions,
        'response': response
      };
}
