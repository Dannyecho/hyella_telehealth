// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'chat_contact_bloc.dart';

abstract class ChatContactEvent {}

class LoadContactListEvent extends ChatContactEvent {}

class FilterContactListEvent extends ChatContactEvent {
  final String term;
  FilterContactListEvent({required this.term});
}

class SetReadCountToZeroEvent extends ChatContactEvent {
  String chatKey;
  String receiverId;
  bool isDoctor;

  SetReadCountToZeroEvent({
    required this.chatKey,
    required this.receiverId,
    required this.isDoctor,
  });
}
