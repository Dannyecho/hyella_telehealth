class RevenueResponseEntity {
  RevenueResponseEntity({
    required this.type,
    required this.msg,
    required this.data,
  });

  final int? type;
  final String? msg;
  final RevenueResponseData? data;

  RevenueResponseEntity copyWith({
    int? type,
    String? msg,
    RevenueResponseData? data,
  }) {
    return RevenueResponseEntity(
      type: type ?? this.type,
      msg: msg ?? this.msg,
      data: data ?? this.data,
    );
  }

  factory RevenueResponseEntity.fromJson(Map<String, dynamic> json) {
    return RevenueResponseEntity(
      type: json["type"],
      msg: json["msg"],
      data: json["data"] == null
          ? null
          : RevenueResponseData.fromJson(json["data"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "type": type,
        "msg": msg,
        "data": data?.toJson(),
      };

  @override
  String toString() {
    return "$type, $msg, $data, ";
  }
}

class RevenueResponseData {
  RevenueResponseData({
    required this.title,
    required this.details,
    required this.totalRevenue,
  });

  final String? title;
  final List<RevenueResponseDataDetail> details;
  final String? totalRevenue;

  RevenueResponseData copyWith({
    String? title,
    List<RevenueResponseDataDetail>? details,
    String? totalRevenue,
  }) {
    return RevenueResponseData(
      title: title ?? this.title,
      details: details ?? this.details,
      totalRevenue: totalRevenue ?? this.totalRevenue,
    );
  }

  factory RevenueResponseData.fromJson(Map<String, dynamic> json) {
    return RevenueResponseData(
      title: json["title"],
      details: json["details"] == null
          ? []
          : List<RevenueResponseDataDetail>.from(json["details"]!
              .map((x) => RevenueResponseDataDetail.fromJson(x))),
      totalRevenue: json["total_revenue"],
    );
  }

  Map<String, dynamic> toJson() => {
        "title": title,
        "details": details.map((x) => x.toJson()).toList(),
        "total_revenue": totalRevenue,
      };

  @override
  String toString() {
    return "$title, $details, $totalRevenue, ";
  }
}

class RevenueResponseDataDetail {
  RevenueResponseDataDetail({
    required this.title,
    required this.amount,
  });

  final String? title;
  final String? amount;

  RevenueResponseDataDetail copyWith({
    String? title,
    String? amount,
  }) {
    return RevenueResponseDataDetail(
      title: title ?? this.title,
      amount: amount ?? this.amount,
    );
  }

  factory RevenueResponseDataDetail.fromJson(Map<String, dynamic> json) {
    return RevenueResponseDataDetail(
      title: json["title"],
      amount: json["amount"],
    );
  }

  Map<String, dynamic> toJson() => {
        "title": title,
        "amount": amount,
      };

  @override
  String toString() {
    return "$title, $amount, ";
  }
}
