// import 'package:agora_chat_sdk/agora_chat_sdk.dart';
import 'package:bloc/bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:hyella_telehealth/core/global.dart';
import 'package:hyella_telehealth/data/repository/apis/chat_api.dart';
import 'package:hyella_telehealth/data/repository/entities/chat_entity.dart';
import 'package:hyella_telehealth/data/repository/entities/endpoint_entity.dart';
import 'package:hyella_telehealth/data/repository/entities/login_response_entity.dart';
import 'package:hyella_telehealth/presentation/widgets/toast_info.dart';
import 'package:intl/intl.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  EndPointEntityData? appEndpoints = Global.storageService.getEndpoints();
  late ScrollController scrollController;
  Data? appdata = Global.storageService.getAppData();
  String tempAppKey = '6e1ee3344b4344ffba2e0c4005d17c9c';
  String tempAppToken =
      '007eJxTYFgUdX3l4ldHrJ8qaWs99tgf5XyT+VVC4DtW/pBX1fl+VYsVGMxSDVNTjY1NTJJMgERaWlKiUapBsomBgWmKoXmyZXKo4fu0hkBGBr1zB5kZGVgZGBmYGEB8BgYAwtAeYg==';
  // late ChatClient agoraChatClient;

  ChatBloc()
      : super(ChatState(
          appKey: '',
          userId: '',
          token: '',
          msgContent: '',
          isJoined: false,
          hasError: false,
          isSendingMessage: false,
          selectedImages: [],
          selectedFiles: [],
        )) {
    on<InitializeChatEvent>((event, emit) {
      emit(state.copyWith(chatPageData: event.chatPageData));
      try {
        // setupChatClient(appEndpoints!.agoraApiKey!);
        // Login to Agora
        // add(JoinChatEvent());
        // Setup chat listeners
        // setupListeners();
        // Fetch conversation from server
        scrollController = event.scrollController;
        add(GetChatConversationEvent());
        // scrollToBottomWithInset(100);
      } catch (e) {
        emit(state.copyWith(hasError: true));
      }
    });

    on<JoinChatEvent>(
      (event, emit) async {
        /* if (!state.isJoined) {
          // Log in
          try {
            await agoraChatClient.loginWithAgoraToken(
                state.chatPageData!.pid!, tempAppToken);
            print("Logged in successfully");
            emit(state.copyWith(isJoined: true));
          } on ChatError catch (e) {
            if (e.code == 200) {
              // Already logged in
              emit(state.copyWith(isJoined: true, hasError: false));
            } else {
              toastInfo(msg: e.description);
              print("Error here======================");
            }
          }
        } */
      },
    );

    on<LeaveChatEvent>(
      (event, emit) async {
        /*   // Log out
        if (state.isJoined) {
          try {
            await agoraChatClient.logout(true);
            print("Logged out successfully");
            emit(state.copyWith(isJoined: false));
          } on ChatError catch (e) {
            toastInfo(msg: e.description);
          }
        } */
      },
    );

    on<GetChatConversationEvent>(
      (event, emit) async {
        var chatPageData = state.chatPageData!;
        ChatListResponseEntity chatListResponseEntity =
            await ChatApi().getConversations(
          chatPageData.receiverId!,
        );

        if (chatListResponseEntity.type == 0) {
          emit(state.copyWith(hasError: true));
          toastInfo(msg: chatListResponseEntity.msg);
          return;
        }

        // scrollToBottom();
        // scrollToBottomWithInset(event.scrollController, 100);
        emit(state.copyWith(
          conversations: chatListResponseEntity.data,
          hasError: false,
        ));
        // scrollToBottomWithInset(100);
      },
    );

    on<TypingMessageEvent>(
      (event, emit) {
        emit(state.copyWith(msgContent: event.text));
      },
    );

    on<SendMessageToServerEvent>((event, emit) {
      sendMessage(
        message: event.msgBody,
        receiverId: event.receiverId,
        isDoctor: appdata!.user!.isStaff == 1,
      );
    });

    on<ClearAllMsgEvent>(
      (event, emit) => emit(state.copyWith(
        msgContent: '',
        selectedFiles: [],
        selectedImages: [],
      )),
    );

    on<DeleteChatEvent>(
      (event, emit) async {
        state.conversations!
            .firstWhere((element) => element.key == event.chatKey)
            .copyWith(isDeleted: true);
        emit(state);

        var messageBody =
            "Delete Message! ${CustomChatType.receipt.getExtension()}${event.chatKey}";
        add(SendMessageToServerEvent(
            msgKey: chatKey,
            msgBody: messageBody,
            receiverId: state.chatPageData!.receiverId!,
            isDoctor: state.chatPageData!.isDoctor!));

        ChatApi().deleteChat(chatKey);
      },
    );

    on<AddImageEvent>(
      (event, emit) {
        var selectedImages = state.selectedImages;
        selectedImages.add(event.path);

        emit(state.copyWith(selectedImages: selectedImages));
      },
    );

    on<AddFilesEvent>(
      (event, emit) {
        var selectedFiles = event.files.files.map((e) => e.path!).toList();
        emit(state.copyWith(selectedFiles: selectedFiles));
      },
    );

    on<RemoveImageEvent>(
      (event, emit) {
        var selectedImages = state.selectedImages;
        selectedImages.remove(event.imagePath);

        emit(state.copyWith(selectedImages: selectedImages));
      },
    );

    on<RemoveFileEvent>(
      (event, emit) {
        var selectedFiles = state.selectedFiles;
        selectedFiles.remove(event.filePath);

        emit(state.copyWith(selectedFiles: selectedFiles));
      },
    );

    on<AddNewMessageEvent>(
      (event, emit) {
        var msgObj = MsgConversation(
            id: '',
            key: event.key,
            date: DateTime.now().millisecondsSinceEpoch,
            source: state.chatPageData!.pid,
            message: event.message,
            read: false);
        var newConversations = state.conversations;
        newConversations!.add(msgObj);

        emit(state.copyWith(conversations: newConversations));
        scrollToBottomWithInset(event.scrollController!, 0);
        // if (event.scrollController != null) {}
      },
    );
  }

  String get chatKey =>
      "${state.chatPageData!.channelId!}*${DateTime.now().millisecondsSinceEpoch}";

  void sendMessage({
    required String message,
    required String receiverId,
    required bool isDoctor,
    List<String>? selectedFiles,
    List<String>? selectedImages,
  }) async {
    try {
      if (message.trim().isEmpty &&
          (selectedFiles == null || selectedFiles.isEmpty) &&
          (selectedImages == null || selectedImages.isEmpty)) {
        toastInfo(msg: "Provide a message to send!");
        return;
      }

      // show loader
      // sendingMessage = true;
      if (selectedFiles != null && selectedFiles.isNotEmpty) {
        await sendFileMessage(
          receiverId: receiverId,
          isDoctor: isDoctor,
          selectedFiles: selectedFiles,
          type: CustomChatType.file,
        );
      }

      if (selectedImages != null && selectedImages.isNotEmpty) {
        await sendFileMessage(
            receiverId: receiverId,
            isDoctor: isDoctor,
            selectedFiles: selectedImages,
            type: CustomChatType.image);
      }

      // Send Text Message if not empty
      if (message.trim().isNotEmpty) {
        String cKey = chatKey;
        var messageBody =
            "${message.trim()}${CustomChatType.text.getExtension()}${ChatDelimiters.chatKeyDelimeter}$cKey";
        var sendToServer =
            ChatApi().sendTextMessageToServer(messageBody, cKey, receiverId);

        add(AddNewMessageEvent(key: cKey, message: message));

        /* var msg = ChatMessage.createTxtSendMessage(
          targetId: receiverId,
          content: message,
        );

        ChatClient.getInstance.chatManager.addMessageEvent(
          chatKey,
          ChatMessageEvent(
            onSuccess: (msgId, msg) {
              print("on message succeed");
            },
            onProgress: (msgId, progress) {
              print("on message progress");
            },
            onError: (msgId, msg, error) {
              print(
                  "on message failed, code: ${error.code}, desc: ${error.description}");
            },
          ),
        );
        ChatClient.getInstance.chatManager.removeMessageEvent(chatKey);
        agoraChatClient.chatManager.sendMessage(msg); */
      }
    } catch (e) {
      toastInfo(msg: "Error on sending message");
    }
  }

  void scrollToBottom(ScrollController scrollController) {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 20),
      curve: Curves.easeInOut,
    );
  }

  Future<void> sendFileMessage(
      {required String receiverId,
      required bool isDoctor,
      required List<String> selectedFiles,
      required CustomChatType type}) async {
    Map<String, dynamic> files = Map.fromIterable(selectedFiles,
        value: (el) => selectedFiles.elementAt(el));

    var uploadResponse =
        await ChatApi().sendChatFiles(receiverId: receiverId, files: files);
    if (uploadResponse.type == 0) {
      toastInfo(msg: uploadResponse.msg!);
      return;
    }

    /* var newMessage = MsgConversation(
      id: null,
      key: chatKey,
      date: DateTime.now().millisecondsSinceEpoch,
      source: state.chatPageData!.pid,
      message: uploadResponse.data!.attachmentUrl,
      read: false,
    ); */

    // add the message
    // var newConversations = state.conversations;
    add(SendMessageToServerEvent(
        msgKey: chatKey,
        msgBody: uploadResponse.data!.attachmentUrl!,
        receiverId: receiverId,
        isDoctor: isDoctor));
  }

/*   void setupChatClient(String appKey) async {
    ChatOptions options = ChatOptions(
      appKey: tempAppKey,
      autoLogin: false,
    );
    agoraChatClient = ChatClient.getInstance;
    await agoraChatClient.init(options);
    // Notify the SDK that the Ul is ready. After the following method is executed, callbacks within ChatRoomEventHandler and ChatGroupEventHandler can be triggered.
    await ChatClient.getInstance.startCallback();
  }
 */
  void scrollToBottomWithInset(
      ScrollController scrollController, double insets) {
    print("Scrolling with inset...");
    Future.delayed(
      const Duration(milliseconds: 500),
      (() {
        scrollController.jumpTo(
          scrollController.position.maxScrollExtent + insets,
        );
      }),
    );
    print("Scrolling with inset ended....");
  }

  void setupListeners() {
    /* agoraChatClient.addConnectionEventHandler(
      "CONNECTION_HANDLER",
      ConnectionEventHandler(
          onConnected: onConnected,
          onDisconnected: onDisconnected,
          onTokenWillExpire: onTokenWillExpire,
          onTokenDidExpire: onTokenDidExpire),
    );

    agoraChatClient.chatManager.addEventHandler(
      "MESSAGE_HANDLER",
      ChatEventHandler(onMessagesReceived: onMessagesReceived),
    ); */
  }

  /*void onMessagesReceived(List<ChatMessage> messages) {
     for (var msg in messages) {
      if (msg.body.type == MessageType.TXT) {
        ChatTextMessageBody body = msg.body as ChatTextMessageBody;
        displayMessage(body.content, false);
        showLog("Message from ${msg.from}");
      } else {
        String msgType = msg.body.type.name;
        showLog("Received $msgType message, from ${msg.from}");
      }
    } 
  }*/

  void onTokenWillExpire() {
    // The token is about to expire. Get a new token
    // from the token server and renew the token.
  }
  void onTokenDidExpire() {
    // The token has expired
  }
  void onDisconnected() {
    // Disconnected from the Chat server
  }
  void onConnected() {
    print("User Connected to Chat");
  }
}
