import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class AppSettingsEntity {
  RevenueSettings? revenue;
  AppSettingsEntity({
    this.revenue,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'revenue': revenue?.toMap(),
    };
  }

  factory AppSettingsEntity.fromMap(Map<String, dynamic> map) {
    return AppSettingsEntity(
      revenue: map['revenue'] != null
          ? RevenueSettings.fromMap(map['revenue'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AppSettingsEntity.fromJson(String source) =>
      AppSettingsEntity.fromMap(json.decode(source) as Map<String, dynamic>);

  AppSettingsEntity copyWith({
    RevenueSettings? revenue,
  }) {
    return AppSettingsEntity(
      revenue: revenue ?? this.revenue,
    );
  }
}

class RevenueSettings {
  bool openBalance;
  RevenueSettings({
    required this.openBalance,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'openBalance': openBalance,
    };
  }

  factory RevenueSettings.fromMap(Map<String, dynamic> map) {
    return RevenueSettings(
      openBalance: map['openBalance'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory RevenueSettings.fromJson(String source) =>
      RevenueSettings.fromMap(json.decode(source) as Map<String, dynamic>);
}
