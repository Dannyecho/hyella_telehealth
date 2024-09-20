import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:hyella_telehealth/data/repository/apis/msg_contact_api.dart';
import 'package:hyella_telehealth/data/repository/entities/contact_entity.dart';
import 'package:hyella_telehealth/presentation/widgets/toast_info.dart';
import 'package:meta/meta.dart';

part 'chat_contact_event.dart';
part 'chat_contact_state.dart';

class ChatContactBloc extends Bloc<ChatContactEvent, ChatContactState> {
  late MsgContactListData? contactListData;
  ChatContactBloc() : super(ChatContactListLoading()) {
    on<LoadContactListEvent>((event, emit) async {
      print("Loading contact list......");
      emit(ChatContactListLoading());

      var response = await fetContactList();
      if (response!.type == 0) {
        toastInfo(msg: response.msg!);
        emit(ChatContactListLoaded(
            searchText: '', hasError: true, contactListData: null));
      } else {
        contactListData = response.data;
        if (state is ChatContactListLoaded) {
          emit((state as ChatContactListLoaded)
              .copyWith(hasError: false, contactListData: response.data));
        } else {
          emit(ChatContactListLoaded(
              searchText: '', hasError: false, contactListData: response.data));
        }
      }

      print("Loading contact list Loaded......");
    });

    on<FilterContactListEvent>(
      (event, emit) {
        print("Filtering contacts");
        var copyContactListData = contactListData!.copyWith();

        emit(ChatContactListLoading());
        var newList = contactListData!.msgContacts!.where((element) {
          return element.title!
                  .toLowerCase()
                  .contains(event.term.toLowerCase()) ||
              element.subTitle!
                  .toLowerCase()
                  .contains(event.term.toLowerCase());
        }).toList();
        copyContactListData = contactListData!.copyWith(msgContacts: newList);
        emit(
          ChatContactListLoaded(
            searchText: event.term,
            hasError: false,
            contactListData: copyContactListData,
          ),
        );
      },
    );

    on<SetReadCountToZeroEvent>(
      (event, emit) async {
        var newcontacts = contactListData;

        if (newcontacts!.msgContacts!
            .where((element) => element.key == event.chatKey)
            .isNotEmpty) {
          newcontacts.msgContacts!
              .firstWhere((element) => element.key == event.chatKey)
              .unreadMessages = 0;

          add(FilterContactListEvent(
              term: (state as ChatContactListLoaded).searchText));
          print(newcontacts.msgContacts!
              .firstWhere((element) => element.key == event.chatKey));

          emit((state as ChatContactListLoaded)
              .copyWith(contactListData: newcontacts));

          print("----------------------------------------");
        }

        var response = await MsgContactApi()
            .setChatToRead(event.chatKey, event.receiverId, event.isDoctor);

        if (response['type'] == 0) {
          toastInfo(msg: response['msg']);
        }
      },
    );
  }

  Future<MsgContactListResponse?> fetContactList() async {
    var response = await MsgContactApi().getContactList();
    return response;
  }
}
