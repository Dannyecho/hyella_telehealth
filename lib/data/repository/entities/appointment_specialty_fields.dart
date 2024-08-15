import 'package:hyella_telehealth/data/repository/entities/select_option_entity.dart';

class AppointmentSpecialtyFields {
  AppointmentSpecialtyFields({
    required this.fieldLabel,
    required this.listOption,
    required this.dependentFieldLabel,
    required this.dependentListOption,
  });

  final String? fieldLabel;
  final List<SelectOptionEntity>? listOption;
  final String? dependentFieldLabel;
  final List<SelectOptionEntity>? dependentListOption;

  AppointmentSpecialtyFields copyWith({
    String? fieldLabel,
    List<SelectOptionEntity>? listOption,
    String? dependentFieldLabel,
    List<SelectOptionEntity>? dependentListOption,
  }) {
    return AppointmentSpecialtyFields(
      fieldLabel: fieldLabel ?? this.fieldLabel,
      listOption: listOption ?? this.listOption,
      dependentFieldLabel: dependentFieldLabel ?? this.dependentFieldLabel,
      dependentListOption: dependentListOption ?? this.dependentListOption,
    );
  }

  factory AppointmentSpecialtyFields.fromJson(Map<String, dynamic> json) {
    return AppointmentSpecialtyFields(
      fieldLabel: json["field_label"],
      listOption: json["list_option"] == null
          ? null
          : (json["list_option"] as Map)
              .entries
              .map((entry) =>
                  SelectOptionEntity(name: entry.key, value: entry.value))
              .toList(),
      dependentFieldLabel: json["dependent_field_label"],
      dependentListOption: json["dependent_list_option"] == null
          ? null
          : (json["dependent_list_option"] as Map)
              .entries
              .map((entry) =>
                  SelectOptionEntity(name: entry.key, value: entry.value))
              .toList(),
    );
  }

  /* Map<String, dynamic> toJson() => {
        "field_label": fieldLabel,
        "list_option": listOption.toString(),
        "dependent_field_label": dependentFieldLabel,
        "dependent_list_option": dependentListOption?.toJson(),
      }; */

  @override
  String toString() {
    return "$fieldLabel, ${listOption.toString()}, $dependentFieldLabel, ${dependentListOption.toString()}, ";
  }
}
