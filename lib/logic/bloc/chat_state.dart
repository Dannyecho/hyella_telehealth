// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'chat_bloc.dart';

@immutable
abstract final class ChatState {}

final class ChatContactListLoading extends ChatState {}

final class ChatContactListLoaded extends ChatState {
  final MsgContactListData? contactListData;
  final bool hasError;
  ChatContactListLoaded({
    required this.hasError,
    required this.contactListData,
  });

  ChatContactListLoaded copyWith({
    MsgContactListData? contactListData,
    bool? hasError,
  }) {
    return ChatContactListLoaded(
      contactListData: contactListData ?? this.contactListData,
      hasError: hasError ?? this.hasError,
    );
  }
}
