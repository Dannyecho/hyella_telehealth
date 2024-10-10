// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'chat_bloc.dart';

abstract class ChatEvent {}

class InitializeChatEvent extends ChatEvent {
  ChatPageData chatPageData;
  final ScrollController scrollController;
  InitializeChatEvent({
    required this.chatPageData,
    required this.scrollController,
  });
}

class GetChatConversationEvent extends ChatEvent {
  GetChatConversationEvent();
}

class JoinChatEvent extends ChatEvent {}

class LeaveChatEvent extends ChatEvent {}

class DeleteChatEvent extends ChatEvent {
  String chatKey;
  DeleteChatEvent({
    required this.chatKey,
  });
}

class SendMessageToServerEvent extends ChatEvent {
  String msgKey;
  String msgBody;
  String receiverId;
  bool isDoctor;

  SendMessageToServerEvent({
    required this.msgKey,
    required this.msgBody,
    required this.receiverId,
    required this.isDoctor,
  });
}

class AddImageEvent extends ChatEvent {
  final String path;
  AddImageEvent({
    required this.path,
  });
}

class AddFilesEvent extends ChatEvent {
  final FilePickerResult files;
  AddFilesEvent({
    required this.files,
  });
}

class RemoveImageEvent extends ChatEvent {
  final String imagePath;
  RemoveImageEvent({
    required this.imagePath,
  });
}

class RemoveFileEvent extends ChatEvent {
  final String filePath;
  RemoveFileEvent({
    required this.filePath,
  });
}

class TypingMessageEvent extends ChatEvent {
  final String text;
  final ScrollController scrollController;
  TypingMessageEvent({
    required this.text,
    required this.scrollController,
  });
}

class AddNewMessageEvent extends ChatEvent {
  final String key;
  final String message;
  ScrollController? scrollController;

  AddNewMessageEvent({
    required this.key,
    required this.message,
    this.scrollController,
  });
}

class ClearAllMsgEvent extends ChatEvent {}
