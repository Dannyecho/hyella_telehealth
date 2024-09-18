import 'package:bloc/bloc.dart';
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
      contactListData = await event.fetContactList(emit, state);
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
  }
}
