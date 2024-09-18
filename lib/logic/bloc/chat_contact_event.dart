part of 'chat_contact_bloc.dart';

abstract class ChatContactEvent {}

class LoadContactListEvent extends ChatContactEvent {
  Future<MsgContactListData?> fetContactList(
      Emitter emit, ChatContactState state) async {
    emit(ChatContactListLoading());
    var response = await MsgContactApi().getContactList();
    if (response!.type == 0) {
      toastInfo(msg: response.msg!);
      emit(ChatContactListLoaded(
          searchText: '', hasError: true, contactListData: null));
    } else {
      if (state is ChatContactListLoaded) {
        emit(state.copyWith(hasError: false, contactListData: response.data));
      } else {
        emit(ChatContactListLoaded(
            searchText: '', hasError: false, contactListData: response.data));
      }

      return response.data;
    }
    return null;
  }
}

class FilterContactListEvent extends ChatContactEvent {
  final String term;
  FilterContactListEvent({required this.term});
}
