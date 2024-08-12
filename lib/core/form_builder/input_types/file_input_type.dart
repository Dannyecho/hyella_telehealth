import 'package:hyella_telehealth/core/form_builder/input_types/base_input_type.dart';

class FileInputType extends BaseInputType {
  final String? name;
  final String? fieldLabel;
  final String? formField;
  final int? requiredField;
  final String? note;
  final int? min;
  final int? max;
  final String? acceptableFilesFormat;
  String? response;
  final String? validationMessage;

  FileInputType(
      {this.name,
      this.fieldLabel,
      this.formField,
      this.requiredField,
      this.note,
      this.min,
      this.validationMessage,
      this.max,
      this.acceptableFilesFormat,
      this.response});

  FileInputType.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String?,
        fieldLabel = json['field_label'] as String?,
        formField = json['form_field'] as String?,
        requiredField = json['required_field'] as int?,
        note = json['note'] as String?,
        min = json['min'] as int?,
        max = json['max'] as int?,
        response = '',
        acceptableFilesFormat = json['acceptable_files_format'] as String?,
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
        'acceptable_files_format': acceptableFilesFormat,
        'response': response
      };
}
