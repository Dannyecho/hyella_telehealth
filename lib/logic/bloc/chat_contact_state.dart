// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'chat_contact_bloc.dart';

@immutable
abstract final class ChatContactState {}

final class ChatContactListLoading extends ChatContactState {}

final class ChatContactListLoaded extends ChatContactState {
  final MsgContactListData? contactListData;
  final bool hasError;
  final String searchText;
  ChatContactListLoaded({
    required this.searchText,
    required this.hasError,
    required this.contactListData,
  });

  ChatContactListLoaded copyWith({
    String? searchText,
    MsgContactListData? contactListData,
    bool? hasError,
  }) {
    return ChatContactListLoaded(
      searchText: searchText ?? this.searchText,
      contactListData: contactListData ?? this.contactListData,
      hasError: hasError ?? this.hasError,
    );
  }
}
