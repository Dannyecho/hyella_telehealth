class LabResultEntity {
  LabResultEntity({
    required this.key,
    required this.data,
  });

  final String? key;
  final List<LabResultEntityDatum> data;

  LabResultEntity copyWith({
    String? key,
    List<LabResultEntityDatum>? data,
  }) {
    return LabResultEntity(
      key: key ?? this.key,
      data: data ?? this.data,
    );
  }

  factory LabResultEntity.fromJson(Map<String, dynamic> json) {
    return LabResultEntity(
      key: json["key"],
      data: json["data"] == null
          ? []
          : List<LabResultEntityDatum>.from(
              json["data"]!.map((x) => LabResultEntityDatum.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "key": key,
        "data": data.map((x) => x?.toJson()).toList(),
      };

  @override
  String toString() {
    return "$key, $data, ";
  }
}

class LabResultEntityDatum {
  LabResultEntityDatum({
    required this.key,
    required this.info,
    required this.title,
    required this.subTitle,
    required this.message,
    required this.date,
    required this.menuKey,
    required this.url,
  });

  final String? key;
  final String? info;
  final String? title;
  final String? subTitle;
  final String? message;
  final int? date;
  final String? menuKey;
  final String? url;

  LabResultEntityDatum copyWith({
    String? key,
    String? info,
    String? title,
    String? subTitle,
    String? message,
    int? date,
    String? menuKey,
    String? url,
  }) {
    return LabResultEntityDatum(
      key: key ?? this.key,
      info: info ?? this.info,
      title: title ?? this.title,
      subTitle: subTitle ?? this.subTitle,
      message: message ?? this.message,
      date: date ?? this.date,
      menuKey: menuKey ?? this.menuKey,
      url: url ?? this.url,
    );
  }

  factory LabResultEntityDatum.fromJson(Map<String, dynamic> json) {
    return LabResultEntityDatum(
      key: json["key"],
      info: json["info"],
      title: json["title"],
      subTitle: json["sub_title"],
      message: json["message"],
      date: json["date"],
      menuKey: json["menu_key"],
      url: json["url"],
    );
  }

  Map<String, dynamic> toJson() => {
        "key": key,
        "info": info,
        "title": title,
        "sub_title": subTitle,
        "message": message,
        "date": date,
        "menu_key": menuKey,
        "url": url,
      };

  @override
  String toString() {
    return "$key, $info, $title, $subTitle, $message, $date, $menuKey, $url, ";
  }
}
