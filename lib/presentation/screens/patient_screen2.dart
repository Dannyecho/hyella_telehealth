import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hyella_telehealth/data/repository/entities/login_response_entity.dart';
import 'package:hyella_telehealth/logic/bloc/app_bloc.dart';
import 'package:hyella_telehealth/logic/bloc/app_screen_bloc.dart';
import 'package:hyella_telehealth/logic/bloc/chat_contact_bloc.dart';
import 'package:hyella_telehealth/presentation/route/app_route.dart';
import 'package:hyella_telehealth/presentation/screens/widgets/patient_screen_widgets.dart';

class PatientScreen2 extends StatefulWidget {
  final int? index;
  const PatientScreen2({super.key, this.index});

  @override
  // ignore: library_private_types_in_public_api
  _PatientScreen2State createState() => _PatientScreen2State();
}

class _PatientScreen2State extends State<PatientScreen2> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppScreenBloc, AppScreenState>(
      builder: (context, state) {
        return PopScope(
          canPop: context.read<AppScreenBloc>().state.index == 0 ? true : false,
          onPopInvoked: (didPop) {
            context.read<AppScreenBloc>().add(SwitchScreen(index: 0));
          },
          child: Scaffold(
              resizeToAvoidBottomInset: false,
              floatingActionButton: FloatingActionButton(
                elevation: 8,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                backgroundColor: Theme.of(context).primaryColor,
                /* child: const Icon(
                  Icons.medical_services,
                  color: Colors.white,
                ), */
                child: Image.asset(
                  'assets/images/logo-white.png',
                  // color: Colors.white,
                  width: 48,
                  height: 48,
                ),
                onPressed: () {
                  context.read<AppScreenBloc>().add(SwitchScreen(index: 4));
                },
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              bottomNavigationBar: BottomAppBar(
                height: 70,
                elevation: 8,
                color: Colors.white,
                shadowColor: Colors.lightBlueAccent,
                shape: const CircularNotchedRectangle(),
                notchMargin: 10,
                child: SizedBox(
                  height: 60,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MaterialButton(
                            minWidth: 40,
                            onPressed: () {
                              context
                                  .read<AppScreenBloc>()
                                  .add(SwitchScreen(index: 0));
                            },
                            child: Column(
                              children: [
                                Icon(
                                  Icons.home_filled,
                                  color: state.index == 0
                                      ? Theme.of(context).primaryColor
                                      : Colors.blueGrey,
                                ),
                                Text(
                                  "Home",
                                  style: TextStyle(
                                    color: state.index == 0
                                        ? Theme.of(context).primaryColor
                                        : Colors.blueGrey,
                                  ),
                                )
                              ],
                            ),
                          ),
                          MaterialButton(
                            minWidth: 40,
                            onPressed: () {
                              context
                                  .read<AppScreenBloc>()
                                  .add(SwitchScreen(index: 1));
                            },
                            child: Stack(
                              children: [
                                Column(
                                  children: [
                                    Icon(
                                      Icons.comment,
                                      color: state.index == 1
                                          ? Theme.of(context).primaryColor
                                          : Colors.blueGrey,
                                    ),
                                    Text(
                                      "Chats",
                                      style: TextStyle(
                                        color: state.index == 1
                                            ? Theme.of(context).primaryColor
                                            : Colors.blueGrey,
                                      ),
                                    ),
                                  ],
                                ),
                                BlocBuilder<ChatContactBloc, ChatContactState>(
                                  builder: (context, state) {
                                    if (state is ChatContactListLoading) {
                                      return const Positioned(
                                        top: 0,
                                        right: 0,
                                        child: SizedBox(
                                          width: 16,
                                          height: 16,
                                          child: CircularProgressIndicator(),
                                        ),
                                      );
                                    }

                                    int newMessages = 0;
                                    if (state is ChatContactListLoaded &&
                                        state.hasError == false) {
                                      newMessages = state
                                          .contactListData!.msgContacts!
                                          .where((element) =>
                                              element.unreadMessages! > 0)
                                          .length;
                                    }
                                    if (newMessages > 0) {
                                      return Positioned(
                                        right: 0,
                                        top: 0,
                                        child: CircleAvatar(
                                          radius: 8,
                                          backgroundColor: Colors.blue,
                                          child: Text(
                                            newMessages.toString(),
                                            style: const TextStyle(
                                              fontSize: 8,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                    print("Contact List is 0==========");
                                    return Container();
                                  },
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MaterialButton(
                            minWidth: 40,
                            onPressed: () {
                              context
                                  .read<AppScreenBloc>()
                                  .add(SwitchScreen(index: 2));
                            },
                            child: Column(
                              children: [
                                Icon(
                                  Icons.schedule_rounded,
                                  color: state.index == 2
                                      ? Theme.of(context).primaryColor
                                      : Colors.blueGrey,
                                ),
                                Text(
                                  'Schedule',
                                  style: TextStyle(
                                    color: state.index == 2
                                        ? Theme.of(context).primaryColor
                                        : Colors.blueGrey,
                                  ),
                                )
                              ],
                            ),
                          ),
                          MaterialButton(
                            minWidth: 40,
                            onPressed: () {
                              context
                                  .read<AppScreenBloc>()
                                  .add(SwitchScreen(index: 3));
                            },
                            child: Column(
                              children: [
                                Icon(
                                  Icons.more,
                                  color: state.index == 3
                                      ? Theme.of(context).primaryColor
                                      : Colors.blueGrey,
                                ),
                                Text(
                                  "More",
                                  style: TextStyle(
                                    color: state.index == 3
                                        ? Theme.of(context).primaryColor
                                        : Colors.blueGrey,
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              body: buildScreen2(context, state.index)),
        );
      },
    );
  }
}
