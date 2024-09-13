import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hyella_telehealth/data/repository/entities/contact_entity.dart';
import 'package:hyella_telehealth/logic/bloc/chat_bloc.dart';

class ChatContactPage extends StatefulWidget {
  const ChatContactPage({super.key});

  @override
  State<ChatContactPage> createState() => _ChatContactPageState();
}

class _ChatContactPageState extends State<ChatContactPage> {
  List<MsgContact>? contactList;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<ChatBloc>().add(LoadContactListEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatBloc, ChatState>(
      builder: (context, state) {
        return Scaffold(
          body: state is ChatContactListLoading
              ? const CircularProgressIndicator()
              : state is ChatContactListLoaded && state.hasError
                  ? Center(
                      child: Column(
                      children: [
                        const Text("Error loading chats. Try again"),
                        ElevatedButton(
                            onPressed: () {
                              context
                                  .read<ChatBloc>()
                                  .add(LoadContactListEvent());
                            },
                            child: const Text("Refresh")),
                      ],
                    ))
                  : Container(),
        );
      },
    );
  }
}
