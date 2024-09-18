import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hyella_telehealth/logic/bloc/chat_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shimmer/shimmer.dart';

Widget shimmerEffect(BuildContext context) {
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: ListView.builder(
      itemBuilder: (context, index) => Container(
        height: 60,
        margin: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 16,
        ),
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(
              5,
            ),
          ),
        ),
      ),
      itemCount: 8,
    ),
  );
}

Widget sendMessageWidget(BuildContext context) {
  var chatBloc = context.read<ChatBloc>();
  return Padding(
    padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15),
    child: Row(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(20))),
                    builder: (context) => Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        ListTile(
                          title: const Text("Add Image From Camera"),
                          leading: const Icon(Icons.camera_alt),
                          onTap: () async {
                            var file = await takePhoto(ImageSource.camera);
                            if (file != null) {
                              chatBloc.add(AddImageEvent(path: file.path));
                            }

                            Navigator.pop(context);
                          },
                        ),
                        ListTile(
                          title: const Text("Add Image From Gallery"),
                          leading: const Icon(Icons.photo),
                          onTap: () async {
                            var file = await takePhoto(ImageSource.gallery);
                            if (file != null) {
                              chatBloc.add(AddImageEvent(path: file.path));
                            }
                            Navigator.pop(context);
                          },
                        ),
                        ListTile(
                          title: const Text("Add File"),
                          leading: const Icon(Icons.folder),
                          onTap: () async {
                            FilePickerResult? result =
                                await FilePicker.platform.pickFiles(
                              type: FileType.custom,
                              allowMultiple: false,
                              allowCompression: true,
                              allowedExtensions: ['pdf', 'doc'],
                            );

                            if (result != null) {
                              chatBloc.add(AddFilesEvent(files: result));
                            }
                          },
                        ),
                        const SizedBox(
                          height: 30,
                        )
                      ],
                    ),
                  );
                },
                icon: CircleAvatar(
                  backgroundColor: Theme.of(context).splashColor,
                  child: const Icon(
                    Icons.add,
                    size: 15,
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * .6,
                child: TextField(
                  // controller: messageController,
                  keyboardType: TextInputType.multiline,
                  minLines: 1,
                  maxLines: 7,
                  onTap: () async {
                    Future.delayed(const Duration(seconds: 1), () {
                      context.read<ChatBloc>().scrollToBottomWithInset(
                          MediaQuery.of(context).viewInsets.bottom);
                    });
                  },
                  onChanged: (value) {
                    context
                        .read<ChatBloc>()
                        .add(TypingMessageEvent(text: value));
                  },
                  decoration: const InputDecoration(
                    hintText: 'Message...',
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
        ),
        const Spacer(),
        chatBloc.state.isSendingMessage
            ? const CircularProgressIndicator()
            : GestureDetector(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Icon(
                    Icons.send,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
                onTap: () {
                  chatBloc.add(SendMessageToServerEvent(
                      msgKey: chatBloc.chatKey,
                      msgBody: chatBloc.state.msgContent!,
                      receiverId: chatBloc.state.chatPageData!.receiverId!,
                      isDoctor: chatBloc.state.chatPageData!.isDoctor!));

                  chatBloc.add(ClearAllMsgEvent());
                },
              )
      ],
    ),
  );
}

ImagePicker _picker = ImagePicker();

Future<XFile?> takePhoto(ImageSource source) async {
  return await _picker.pickImage(source: source);
}
