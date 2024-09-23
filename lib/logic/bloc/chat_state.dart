part of 'chat_bloc.dart';

class ChatState {
  final String appKey;
  final String userId;
  final String token;
  final List<MsgConversation>? conversations;
  // final ChatClient? agoraChatClient;
  final bool isJoined;
  final ChatPageData? chatPageData;
  final String? msgContent;
  final bool hasError;
  final List<String> selectedImages;
  final List<String> selectedFiles;
  final bool isSendingMessage;

  ChatState({
    required this.hasError,
    required this.appKey,
    required this.userId,
    required this.token,
    required this.isJoined,
    this.chatPageData,
    // this.agoraChatClient,
    this.conversations,
    this.msgContent,
    required this.selectedImages,
    required this.selectedFiles,
    required this.isSendingMessage,
  });

  ChatState copyWith({
    String? appKey,
    String? userId,
    String? token,
    // ChatClient? agoraChatClient,
    bool? isJoined,
    bool? hasError,
    List<MsgConversation>? conversations,
    ChatPageData? chatPageData,
    String? msgContent,
    List<String>? selectedImages,
    List<String>? selectedFiles,
    bool? isSendingMessage,
  }) {
    return ChatState(
      hasError: hasError ?? this.hasError,
      appKey: appKey ?? this.appKey,
      userId: userId ?? this.userId,
      token: token ?? this.token,
      isJoined: isJoined ?? this.isJoined,
      chatPageData: chatPageData ?? this.chatPageData,
      // agoraChatClient: agoraChatClient ?? this.agoraChatClient,
      conversations: conversations ?? this.conversations,
      msgContent: msgContent ?? this.msgContent,
      selectedImages: selectedImages ?? this.selectedImages,
      selectedFiles: selectedFiles ?? this.selectedFiles,
      isSendingMessage: isSendingMessage ?? this.isSendingMessage,
    );
  }

  Map<String, List<MsgConversation>> get groupedByDateCoversations {
    var returnVal = <String, List<MsgConversation>>{};
    for (var el in conversations!) {
      String key = DateFormat('dd MMM yyyy').format(
        DateTime.fromMillisecondsSinceEpoch(
          el.date ?? DateTime.now().millisecondsSinceEpoch,
        ),
      );
      if (returnVal.containsKey(key)) {
        returnVal[key]!.add(el);
      } else {
        returnVal[key] = <MsgConversation>[];
        returnVal[key]!.add(el);
      }
    }

    // print(returnVal);
    return returnVal;
  }
}
