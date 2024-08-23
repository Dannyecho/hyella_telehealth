import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class SelectOptionEntity {
  String name;
  String value;

  SelectOptionEntity({
    required this.name,
    required this.value,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'value': value,
    };
  }

  factory SelectOptionEntity.fromMap(Map<String, dynamic> map) {
    return SelectOptionEntity(
      name: map['name'] as String,
      value: map['value'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SelectOptionEntity.fromJson(String source) =>
      SelectOptionEntity.fromMap(json.decode(source) as Map<String, dynamic>);
  @override
  String toString() {
    super.toString();
    return value;
  }

  @override
  bool operator ==(covariant SelectOptionEntity other) {
    if (identical(this, other)) return true;

    return other.name == name && other.value == value;
  }

  @override
  int get hashCode => name.hashCode ^ value.hashCode;
}
