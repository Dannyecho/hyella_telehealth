// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:hyella_telehealth/core/utils/app_util.dart';

class ChatPageData {
  ChatPageData({
    required this.pid,
    required this.picture,
    required this.receiverName,
    required this.channelId,
    required this.receiverId,
    required this.isDoctor,
    required this.key,
  });

  final String? pid;
  final String? picture;
  final String? receiverName;
  final String? channelId;
  final String? receiverId;
  final bool? isDoctor;
  final String? key;

  ChatPageData copyWith({
    String? pid,
    String? picture,
    String? receiverName,
    String? channelId,
    String? receiverId,
    bool? isDoctor,
    String? key,
  }) {
    return ChatPageData(
      pid: pid ?? this.pid,
      picture: picture ?? this.picture,
      receiverName: receiverName ?? this.receiverName,
      channelId: channelId ?? this.channelId,
      receiverId: receiverId ?? this.receiverId,
      isDoctor: isDoctor ?? this.isDoctor,
      key: key ?? this.key,
    );
  }

  factory ChatPageData.fromJson(Map<String, dynamic> json) {
    return ChatPageData(
      pid: json["pid"],
      picture: json["picture"],
      receiverName: json["receiver_name"],
      channelId: json["channel_id"],
      receiverId: json["receiver_id"],
      isDoctor: json["is_doctor"],
      key: json["key"],
    );
  }

  Map<String, dynamic> toJson() => {
        "pid": pid,
        "picture": picture,
        "receiver_name": receiverName,
        "channel_id": channelId,
        "receiver_id": receiverId,
        "is_doctor": isDoctor,
        "key": key,
      };

  @override
  String toString() {
    return "$pid, $picture, $receiverName, $channelId, $receiverId, $isDoctor, $key, ";
  }
}

class MsgConversation {
  MsgConversation({
    required this.id,
    required this.key,
    required this.date,
    required this.source,
    required this.message,
    required this.read,
    this.isDeleted = false,
    this.chatType = CustomChatType.text,
  });

  final String? id;
  final String? key;
  final int? date;
  final String? source;
  final String? message;
  final bool? read;
  final bool? isDeleted;
  final CustomChatType? chatType;

  MsgConversation copyWith({
    String? id,
    String? key,
    int? date,
    String? source,
    String? message,
    bool? read,
    bool? isDeleted,
    CustomChatType? chatType,
  }) {
    return MsgConversation(
      id: id ?? this.id,
      key: key ?? this.key,
      date: date ?? this.date,
      source: source ?? this.source,
      message: message ?? this.message,
      read: read ?? this.read,
      isDeleted: isDeleted ?? this.isDeleted,
      chatType: chatType ?? this.chatType,
    );
  }

  factory MsgConversation.fromJson(Map<String, dynamic> json) {
    CustomChatType? chatType = null;
    for (var delimitter in ChatDelimiters.all) {
      if ((json['message'] as String).contains(delimitter)) {
        switch (delimitter) {
          case ChatDelimiters.deleteChatTypeDelimeter:
            chatType = CustomChatType.delete;
            break;
          case ChatDelimiters.fileChatTypeDelimeter:
            chatType = CustomChatType.file;
            break;
          case ChatDelimiters.imageChatTypeDelimeter:
            chatType = CustomChatType.image;
            break;
          case ChatDelimiters.receiptChatTypeDelimeter:
            chatType = CustomChatType.receipt;
            break;
          default:
            chatType = CustomChatType.text;
            break;
        }
      }
    }

    String msg = AppUtil.stripGetChat(json['message'], json['key']);
    return MsgConversation(
      id: json["id"],
      key: json["key"],
      date: json["date"],
      source: json["source"],
      message: msg,
      read: json["read"],
      chatType: chatType,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "key": key,
        "date": date,
        "source": source,
        "message": message,
        "read": read,
        "isDeleted": isDeleted,
        "chatType": chatType,
      };

  @override
  String toString() {
    return "$id, $key, $date, $source, $message, $read, ";
  }

  static CustomChatType checkType(String message) {
    if (message.contains(ChatDelimiters.imageChatTypeDelimeter)) {
      return CustomChatType.image;
    }
    if (message.contains(ChatDelimiters.fileChatTypeDelimeter)) {
      return CustomChatType.file;
    }
    if (message.contains(ChatDelimiters.receiptChatTypeDelimeter)) {
      return CustomChatType.receipt;
    }

    if (message.contains(ChatDelimiters.textChatTypeDelimeter)) {
      return CustomChatType.text;
    }

    return CustomChatType.delete;
  }

  static String getMainMessage(String messageFromAgora, CustomChatType type) {
    String separator = "";
    switch (type) {
      case CustomChatType.text:
        separator = ChatDelimiters.textChatTypeDelimeter;
        break;
      case CustomChatType.image:
        separator = ChatDelimiters.imageChatTypeDelimeter;
        break;
      case CustomChatType.file:
        separator = ChatDelimiters.fileChatTypeDelimeter;
        break;
      case CustomChatType.receipt:
        separator = ChatDelimiters.receiptChatTypeDelimeter;
        break;
      case CustomChatType.delete:
        separator = ChatDelimiters.deleteChatTypeDelimeter;
    }

    String actualMessage = messageFromAgora.split(separator).first;

    return actualMessage;
  }

  static String getChatKey(String messageFromAgora) {
    String separator = ChatDelimiters.chatKeyDelimeter;
    // the last part of the message is the chatKey
    String messageKey = messageFromAgora.split(separator).last;
    return messageKey;
  }
}

class ChatListResponseEntity {
  final int type;
  final String msg;
  final List<MsgConversation>? data;

  ChatListResponseEntity(
      {required this.type, required this.msg, required this.data});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'type': type,
      'msg': msg,
      'data': {for (var item in data!) (item).key: (item).toJson()}.toString(),
    };
  }

  factory ChatListResponseEntity.fromMap(Map<String, dynamic> json) {
    return ChatListResponseEntity(
      type: json['type'] as int,
      msg: json['msg'] as String,
      data: json['data']['msg_conversation'] != null
          ? (json['data']["msg_conversation"] as Map)
              .entries
              .map((entry) => MsgConversation.fromJson(entry.value))
              .toList()
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatListResponseEntity.fromJson(String source) =>
      ChatListResponseEntity.fromMap(
          json.decode(source) as Map<String, dynamic>);
}

enum CustomChatType { text, image, file, receipt, delete }

class ChatDelimiters {
  static const String chatKeyDelimeter = "****key****";
  static const String fileChatTypeDelimeter = "####file####";
  static const String textChatTypeDelimeter = "####text####";
  static const String imageChatTypeDelimeter = "####image####";
  static const String receiptChatTypeDelimeter = "####receipt####";
  static const String deleteChatTypeDelimeter = "####delete####";

  static get all => [
        chatKeyDelimeter,
        fileChatTypeDelimeter,
        textChatTypeDelimeter,
        imageChatTypeDelimeter,
        receiptChatTypeDelimeter,
        deleteChatTypeDelimeter
      ];
}

extension NameExtension on CustomChatType {
  String getExtension() {
    switch (this) {
      case CustomChatType.text:
        return ChatDelimiters.textChatTypeDelimeter;
      case CustomChatType.image:
        return ChatDelimiters.imageChatTypeDelimeter;
      case CustomChatType.file:
        return ChatDelimiters.fileChatTypeDelimeter;
      case CustomChatType.receipt:
        return ChatDelimiters.receiptChatTypeDelimeter;
      case CustomChatType.delete:
        return ChatDelimiters.deleteChatTypeDelimeter;
    }
  }
}
