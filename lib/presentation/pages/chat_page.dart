import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hyella_telehealth/data/repository/entities/chat_entity.dart';
import 'package:hyella_telehealth/logic/bloc/chat_bloc.dart';
import 'package:hyella_telehealth/presentation/pages/widgets/chat_item.dart';
import 'package:hyella_telehealth/presentation/pages/widgets/chat_widgets.dart';
import 'package:hyella_telehealth/presentation/route/app_route.dart';
import 'package:intl/intl.dart';

class ChatPage extends StatefulWidget {
  final ChatPageData data;
  ChatPage({
    super.key,
    required this.data,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  DateFormat dateFormat = DateFormat('dd MMM yyyy');
  @override
  void initState() {
    super.initState();
    context
        .read<ChatBloc>()
        .add(InitializeChatEvent(chatPageData: widget.data));
  }

  @override
  void dispose() {
    super.dispose();
    context.read<ChatBloc>().add(LeaveChatEvent());
  }

  @override
  Widget build(BuildContext context) {
    print(widget.data.receiverId);

    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 92, 75, 75).withOpacity(.5),
        appBar: AppBar(
          title: Text(
            widget.data.receiverName!,
          ),
          automaticallyImplyLeading: true,
          actions: [
            Visibility(
              visible: context
                      .read<ChatBloc>()
                      .appdata
                      ?.webViews
                      ?.videoChat
                      ?.webview ==
                  1,
              child: IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, AppRoute.webView, arguments: {
                    'url': context
                        .read<ChatBloc>()
                        .appdata
                        ?.webViews
                        ?.videoChat
                        ?.endpoint,
                    'title': "Video Call",
                  }); /* 
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => GeneralWebview(
                          url: GetIt.I<UserDetails>()
                              .webViews!
                              .videoChat!
                              .endpoint!,
                          nwpRequest: GetIt.I<UserDetails>()
                              .webViews!
                              .videoChat!
                              .params!
                              .nwpWebiew!,
                        ),
                      ),
                    ); */
                },
                icon: const Icon(
                  Icons.video_call,
                  size: 30,
                ),
              ),
            ),
          ],
        ),
        body: BlocBuilder<ChatBloc, ChatState>(
          builder: (context, state) {
            return state.hasError
                ? SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Unable to load your chats at the moment\nplease try again later",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            print("Refresh pressed");
                            context.read<ChatBloc>().add(
                                InitializeChatEvent(chatPageData: widget.data));
                          },
                          child: const Text("Tap to retry"),
                        )
                      ],
                    ),
                  )
                : state.conversations == null
                    ? shimmerEffect(context)
                    : Builder(builder: (context) {
                        List groupMsgKeys =
                            state.groupedByDateCoversations.keys.toList();
                        List groupMsgValues =
                            state.groupedByDateCoversations.values.toList();
                        return Column(
                          children: [
                            Expanded(
                              child: ListView.builder(
                                  physics: const ClampingScrollPhysics(),
                                  controller:
                                      context.read<ChatBloc>().scrollController,
                                  itemCount: groupMsgKeys.length,
                                  padding: const EdgeInsets.only(top: 20),
                                  itemBuilder: (context, index) {
                                    String groupDate = groupMsgKeys[index];
                                    List<MsgConversation> groupMsgs =
                                        groupMsgValues[index];

                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Center(
                                          child: Container(
                                            alignment: Alignment.center,
                                            constraints: const BoxConstraints(
                                                maxWidth: 100),
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 3, horizontal: 8),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Text(
                                              (groupDate ==
                                                      dateFormat.format(
                                                          DateTime.now())
                                                  ? "Today"
                                                  : groupDate),
                                              style: const TextStyle(
                                                color: Colors.grey,
                                                fontSize: 10,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Builder(builder: (context) {
                                          MsgConversation? prevChat;
                                          return Column(
                                            children: groupMsgs.map((e) {
                                              bool newLine = false;
                                              if (prevChat != null) {
                                                newLine = prevChat!.source !=
                                                    e.source;
                                              }

                                              prevChat = e;
                                              return ChatItem(
                                                chatModel: e,
                                                pid: state.chatPageData!.pid!,
                                                newLine: newLine,
                                              );
                                            }).toList(),
                                          );
                                        }),
                                        const SizedBox(
                                          height: 10,
                                        )
                                      ],
                                    );
                                  }),
                            ),
                            sendMessageWidget(context),
                            Wrap(
                              children: state.selectedImages
                                  .map(
                                    (e) => Container(
                                      height: 100,
                                      width: 80,
                                      margin: const EdgeInsets.only(top: 10),
                                      child: Stack(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            child: Image.file(
                                              File(e),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                          Positioned(
                                            right: 10,
                                            top: 5,
                                            child: GestureDetector(
                                              onTap: () {
                                                context.read<ChatBloc>().add(
                                                    RemoveImageEvent(
                                                        imagePath: e));
                                              },
                                              child: const Icon(
                                                Icons.close,
                                                color: Colors.white,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Wrap(
                              children: state.selectedFiles
                                  .map(
                                    (e) => Container(
                                      height: 100,
                                      width: 100,
                                      margin: const EdgeInsets.only(top: 10),
                                      child: Stack(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            child: Image.file(
                                              File(e),
                                            ),
                                          ),
                                          Positioned(
                                            right: 5,
                                            child: GestureDetector(
                                              onTap: () {
                                                context.read<ChatBloc>().add(
                                                      RemoveFileEvent(
                                                        filePath: e,
                                                      ),
                                                    );
                                              },
                                              child: const Icon(
                                                Icons.close,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                  .toList(),
                            )
                          ],
                        );
                      });
          },
        ));
  }
}
