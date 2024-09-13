part of 'chat_bloc.dart';

abstract class ChatEvent {}

class LoadContactListEvent extends ChatEvent {
  void fetContactList(Emitter emit) async {
    emit(ChatContactListLoading());
    var response = await MsgContactApi().getContactList();
    if (response!.type == 0) {
      toastInfo(msg: response.msg!);
      emit(ChatContactListLoaded(hasError: true, contactListData: null));
    } else {
      emit(ChatContactListLoaded(
          hasError: false, contactListData: response.data));
    }
  }
}
