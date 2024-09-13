class MsgContactListResponse {
  MsgContactListResponse({
    required this.type,
    required this.msg,
    required this.data,
  });

  final int? type;
  final String? msg;
  final MsgContactListData? data;

  MsgContactListResponse copyWith({
    int? type,
    String? msg,
    MsgContactListData? data,
  }) {
    return MsgContactListResponse(
      type: type ?? this.type,
      msg: msg ?? this.msg,
      data: data ?? this.data,
    );
  }

  factory MsgContactListResponse.fromJson(Map<String, dynamic> json) {
    return MsgContactListResponse(
      type: json["type"],
      msg: json["msg"],
      data: json["data"] == null
          ? null
          : MsgContactListData.fromJson(json["data"]),
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

class MsgContactListData {
  MsgContactListData({
    required this.msgContacts,
    required this.msgContactsCount,
  });

  final List<MsgContact>? msgContacts;
  final int? msgContactsCount;

  MsgContactListData copyWith({
    List<MsgContact>? msgContacts,
    int? msgContactsCount,
  }) {
    return MsgContactListData(
      msgContacts: msgContacts ?? this.msgContacts,
      msgContactsCount: msgContactsCount ?? this.msgContactsCount,
    );
  }

  factory MsgContactListData.fromJson(Map<String, dynamic> json) {
    return MsgContactListData(
      msgContacts: json['msg_contacts'] != null
          ? (json["msg_contacts"] as Map)
              .entries
              .map((entry) => MsgContact.fromJson(entry.value))
              .toList()
          : null,
      msgContactsCount: json["msg_contacts_count"],
    );
  }

  Map<String, dynamic> toJson() => {
        "msg_contacts": msgContacts == null
            ? null
            : {for (var item in msgContacts!) (item).key: (item).toJson()}
                .toString(),
        "msg_contacts_count": msgContactsCount,
      };

  @override
  String toString() {
    return "$msgContacts, $msgContactsCount, ";
  }
}

class MsgContact {
  MsgContact({
    required this.key,
    required this.receiverId,
    required this.title,
    required this.fcmToken,
    required this.channelName,
    required this.picture,
    required this.unreadMessages,
    required this.subTitle,
    required this.lastMessage,
  });

  final String? key;
  final String? receiverId;
  final String? title;
  final String? fcmToken;
  final String? channelName;
  final String? picture;
  final int? unreadMessages;
  final String? subTitle;
  final String? lastMessage;

  MsgContact copyWith({
    String? key,
    String? receiverId,
    String? title,
    String? fcmToken,
    String? channelName,
    String? picture,
    int? unreadMessages,
    String? subTitle,
    String? lastMessage,
  }) {
    return MsgContact(
      key: key ?? this.key,
      receiverId: receiverId ?? this.receiverId,
      title: title ?? this.title,
      fcmToken: fcmToken ?? this.fcmToken,
      channelName: channelName ?? this.channelName,
      picture: picture ?? this.picture,
      unreadMessages: unreadMessages ?? this.unreadMessages,
      subTitle: subTitle ?? this.subTitle,
      lastMessage: lastMessage ?? this.lastMessage,
    );
  }

  factory MsgContact.fromJson(Map<String, dynamic> json) {
    return MsgContact(
      key: json["key"],
      receiverId: json["receiver_id"],
      title: json["title"],
      fcmToken: json["fcm_token"],
      channelName: json["channel_name"],
      picture: json["picture"],
      unreadMessages: json["unread_messages"],
      subTitle: json["sub_title"],
      lastMessage: json["last_message"],
    );
  }

  Map<String, dynamic> toJson() => {
        "key": key,
        "receiver_id": receiverId,
        "title": title,
        "fcm_token": fcmToken,
        "channel_name": channelName,
        "picture": picture,
        "unread_messages": unreadMessages,
        "sub_title": subTitle,
        "last_message": lastMessage,
      };

  @override
  String toString() {
    return "$key, $receiverId, $title, $fcmToken, $channelName, $picture, $unreadMessages, $subTitle, $lastMessage, ";
  }
}
