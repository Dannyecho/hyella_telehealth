import 'dart:io';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_clippers/custom_clippers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hyella_telehealth/data/repository/entities/chat_entity.dart';
import 'package:hyella_telehealth/logic/bloc/chat_bloc.dart';
import 'package:image_preview/preview.dart';
import 'package:image_preview/preview_data.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:preview_file/preview_file.dart';
import 'package:shimmer/shimmer.dart';

class ChatItem extends StatefulWidget {
  final MsgConversation chatModel;
  final String pid;
  final bool newLine;
  ChatItem({
    Key? key,
    required this.chatModel,
    required this.pid,
    required this.newLine,
  }) : super(key: key);

  @override
  State<ChatItem> createState() => _ChatItemState();
}

class _ChatItemState extends State<ChatItem> {
  final DateFormat dateFormat = DateFormat('hh:mm a');

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final chatBloc = context.read<ChatBloc>();
    double chatBoxWidth =
        widget.chatModel.message!.trim().length.toDouble() * 50.0;

    if (chatBoxWidth > deviceWidth * .6 ||
        widget.chatModel.chatType != CustomChatType.text) {
      chatBoxWidth = deviceWidth * .6;
    }
    /*  print(widget.chatModel.message);
    print(widget.chatModel.message!.length);
    print(chatBoxWidth); */

    return Container(
      alignment: (widget.chatModel.source == widget.pid)
          ? Alignment.centerRight
          : Alignment.centerLeft,
      margin: EdgeInsets.only(top: widget.newLine ? 15 : 5, bottom: 5),
      child: ClipPath(
        clipper: (widget.chatModel.source == widget.pid)
            ? UpperNipMessageClipperTwo(MessageType.send)
            : UpperNipMessageClipperTwo(MessageType.receive),
        child: Container(
          // width: chatBoxWidth,
          constraints: BoxConstraints(
            minWidth: 80,
            maxWidth: chatBoxWidth,
          ),
          padding: (widget.chatModel.source == widget.pid)
              ? const EdgeInsets.only(left: 6, top: 6, bottom: 6, right: 20)
              : const EdgeInsets.only(left: 20, top: 6, bottom: 6, right: 6),
          decoration: BoxDecoration(
            color: !(widget.chatModel.source == widget.pid)
                ? Colors.white
                : Colors.green[100],
            boxShadow: const [BoxShadow(blurRadius: 3, color: Colors.grey)],
            borderRadius: BorderRadius.circular(
              10,
            ),
          ),
          child: widget.chatModel.isDeleted!
              ? const Text(
                  "This message is deleted",
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                )
              : GestureDetector(
                  onLongPress: () {
                    showModalBottomSheet(
                      context: context,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                      ),
                      builder: (context) => Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            onTap: () {
                              chatBloc.add(DeleteChatEvent(
                                  chatKey: widget.chatModel.key!));
                              Navigator.pop(context);
                            },
                            title: const Text(
                              "Delete",
                              style: TextStyle(fontSize: 12, color: Colors.red),
                            ),
                            trailing: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          )
                        ],
                      ),
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: deviceWidth * .8,
                        child: FutureBuilder<Widget>(
                          future: showChat(context, widget.chatModel),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Shimmer(
                                gradient: const LinearGradient(
                                  colors: [Colors.black45, Colors.white],
                                ),
                                child: Container(
                                  color: Colors.white,
                                  width: deviceWidth * .7,
                                ),
                              );
                            } else if (snapshot.hasData) {
                              return snapshot.data!;
                            }

                            return const SizedBox();
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            alignment: Alignment.bottomRight,
                            child: Text(
                              dateFormat.format(
                                DateTime.fromMillisecondsSinceEpoch(
                                  widget.chatModel.date!,
                                ),
                              ),
                              style: const TextStyle(
                                fontSize: 10,
                              ),
                            ),
                          ),
                          const SizedBox(width: 5),
                          widget.chatModel.read!
                              ? SizedBox(
                                  width: 20,
                                  child: Stack(
                                    children: [
                                      Icon(
                                        Icons.check,
                                        size: 16,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                      Positioned(
                                        top: 1,
                                        left: 5,
                                        child: Icon(
                                          Icons.check,
                                          size: 16,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : const Icon(
                                  Icons.check,
                                  size: 16,
                                  color: Colors.black45,
                                )
                        ],
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  Future<Widget> showChat(
      BuildContext context, MsgConversation chatModel) async {
    if (chatModel.chatType == CustomChatType.text) {
      return Text(
        chatModel.message!,
        style: const TextStyle(
          fontSize: 14,
        ),
      );
    } else if (chatModel.chatType == CustomChatType.image) {
      return GestureDetector(
        onTap: () async {
          Directory? downloadsDir = await getDownloadsDirectory();
          openPreviewPage(Navigator.of(context),
              data: PreviewData(
                  type: Type.image,
                  image: ImageData(
                    path: downloadsDir!.path + chatModel.key!,
                    url: chatModel.message,
                  ))); /* 
          openImagesPage(
            Navigator.of(context),
            imgUrls: [chatModel.message!],
          ); */
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: CachedNetworkImage(
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                CircularProgressIndicator(value: downloadProgress.progress),
            imageUrl: chatModel.message!,
            height: 100,
            fit: BoxFit.cover,
          ),
        ),
      );
    } else if (chatModel.chatType == CustomChatType.file) {
      final directory = await getTemporaryDirectory();
      int randomInt = Random().nextInt(50000);
      final downloadPath = "${directory.path}/fileview/$randomInt.pdf";
      return FilePreview(
        fileUrl: chatModel.message,
        filePath: downloadPath,
      ).preview();
    }
    return const SizedBox();
  }
}
