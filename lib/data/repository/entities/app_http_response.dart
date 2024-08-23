import 'dart:convert';

class AppHttpResponse {
  final int type;
  final dynamic msg;
  final data;
  AppHttpResponse({
    required this.type,
    required this.msg,
    this.data,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'type': type,
      'msg': msg,
    };
  }

  factory AppHttpResponse.fromMap(Map<String, dynamic> map) {
    return AppHttpResponse(
      type: map['type'] as int,
      msg: map['msg'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AppHttpResponse.fromJson(String source) =>
      AppHttpResponse.fromMap(json.decode(source) as Map<String, dynamic>);
}
