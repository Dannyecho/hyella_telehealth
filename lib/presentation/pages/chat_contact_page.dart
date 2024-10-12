import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hyella_telehealth/data/repository/entities/chat_entity.dart';
import 'package:hyella_telehealth/data/repository/entities/contact_entity.dart';
import 'package:hyella_telehealth/logic/bloc/app_bloc.dart';
import 'package:hyella_telehealth/logic/bloc/chat_contact_bloc.dart';
import 'package:hyella_telehealth/presentation/pages/widgets/chat_contact_page_widgets.dart';
import 'package:hyella_telehealth/presentation/route/app_route.dart';
import 'package:hyella_telehealth/presentation/screens/nav/widgets/shedule_shimmer.dart';

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
    ChatContactState state = context.read<ChatContactBloc>().state;
    if (state is ChatContactListLoaded && state.contactListData != null) {
      contactList = state.contactListData!.msgContacts;
      return;
    }

    context.read<ChatContactBloc>().add(LoadContactListEvent());
  }

  @override
  Widget build(BuildContext context) {
    final double _width = MediaQuery.of(context).size.width;

    return BlocBuilder<ChatContactBloc, ChatContactState>(
      builder: (context, state) {
        if (state is ChatContactListLoaded) {
          contactList = state.contactListData?.msgContacts;
        }

        return Scaffold(
            appBar: AppBar(
              title: const Text(
                'Chats',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: _width * .05),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    buildSearchTextField(context),
                    const SizedBox(
                      height: 5,
                    ),
                    // const Divider(),
                    const SizedBox(
                      height: 5,
                    ),
                    state is ChatContactListLoading
                        ? const Expanded(child: ScheduleShimmer())
                        : state is ChatContactListLoaded && state.hasError
                            ? Center(
                                child: Column(
                                children: [
                                  const Text("Error loading chats. Try again"),
                                  ElevatedButton(
                                      onPressed: () {
                                        context
                                            .read<ChatContactBloc>()
                                            .add(LoadContactListEvent());
                                      },
                                      child: const Text("Refresh")),
                                ],
                              ))
                            : contactList!.isEmpty
                                ? const Center(
                                    child: Text(
                                      "No result found!",
                                    ),
                                  )
                                : Expanded(
                                    child: RefreshIndicator(
                                      onRefresh: () async {
                                        context
                                            .read<ChatContactBloc>()
                                            .add(LoadContactListEvent());
                                      },
                                      child: ListView.separated(
                                        itemCount: contactList!.length,
                                        separatorBuilder: (context, index) =>
                                            const Divider(
                                          thickness: 1,
                                        ),
                                        itemBuilder: (context, index) {
                                          return ListTile(
                                            contentPadding: EdgeInsets.zero,
                                            onTap: () {
                                              var appData = context
                                                  .read<AppBloc>()
                                                  .state
                                                  .appData;
                                              var appUser = context
                                                  .read<AppBloc>()
                                                  .state
                                                  .user;
                                              if (appData!.webViews?.chatMsg
                                                      ?.webview ==
                                                  1) {
                                                Navigator.pushNamed(
                                                    context, AppRoute.webView,
                                                    arguments: {
                                                      'url': appData.webViews
                                                          ?.chat?.endpoint,
                                                      'title': 'Chat',
                                                    });
                                                /* Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    GeneralWebview(
                                                  url: userDetails.webViews!
                                                      .chatMsg!.endpoint!,
                                                  nwpRequest: userDetails
                                                      .webViews!
                                                      .chatMsg!
                                                      .params!
                                                      .nwpWebiew!,
                                                ),
                                              ),
                                            ); */
                                                return;
                                              }

                                              Navigator.of(context).pushNamed(
                                                  AppRoute.chat,
                                                  arguments: ChatPageData(
                                                    pid: appUser?.pid,
                                                    picture: contactList![index]
                                                        .picture,
                                                    receiverName:
                                                        contactList![index]
                                                            .title,
                                                    channelId:
                                                        contactList![index]
                                                            .channelName!,
                                                    receiverId:
                                                        contactList![index]
                                                            .receiverId!,
                                                    isDoctor: false,
                                                    key:
                                                        contactList![index].key,
                                                  ));
                                            },
                                            leading: CircleAvatar(
                                              backgroundColor: Theme.of(context)
                                                  .primaryColor,
                                              radius: 20,
                                              backgroundImage: NetworkImage(
                                                  contactList![index].picture!),
                                            ),
                                            title: Text(
                                              contactList![index].title ?? "",
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 16),
                                            ),
                                            subtitle: Text(
                                              contactList![index].subTitle ??
                                                  "",
                                              style: const TextStyle(
                                                fontSize: 14,
                                              ),
                                            ),
                                            trailing: contactList![index]
                                                        .unreadMessages! >
                                                    0
                                                ? CircleAvatar(
                                                    backgroundColor:
                                                        Colors.blue,
                                                    radius: 10,
                                                    child: Text(
                                                      contactList![index]
                                                          .unreadMessages
                                                          .toString(),
                                                      style: const TextStyle(
                                                        fontSize: 10,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  )
                                                : const SizedBox(),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                  ],
                ),
              ),
            ));
      },
    );
  }
}
