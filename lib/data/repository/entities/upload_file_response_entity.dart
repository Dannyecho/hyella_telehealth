class UploadFIleResponseEntity {
  final int? type;
  final String? msg;
  final UploadFileResponseDataEntity? data;

  UploadFIleResponseEntity({
    this.type,
    this.msg,
    this.data,
  });

  UploadFIleResponseEntity.fromJson(Map<String, dynamic> json)
      : type = json['type'] as int?,
        msg = json['msg'] as String?,
        data = (json['data'] as Map<String, dynamic>?) != null
            ? UploadFileResponseDataEntity.fromJson(
                json['data'] as Map<String, dynamic>)
            : null;

  Map<String, dynamic> toJson() =>
      {'type': type, 'msg': msg, 'data': data?.toJson()};
}

class UploadFileResponseDataEntity {
  final String? attachmentName;
  final String? attachmentUrl;
  final String? errorMsg;

  UploadFileResponseDataEntity({
    this.attachmentName,
    this.attachmentUrl,
    this.errorMsg,
  });

  UploadFileResponseDataEntity.fromJson(Map<String, dynamic> json)
      : attachmentName = json['attachment_name'] as String?,
        attachmentUrl = json['attachment_url'] as String?,
        errorMsg = json['error_msg'] as String?;

  Map<String, dynamic> toJson() => {
        'attachment_name': attachmentName,
        'attachment_url': attachmentUrl,
        'error_msg': errorMsg
      };
}
