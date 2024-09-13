import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:hyella_telehealth/data/repository/apis/msg_contact_api.dart';
import 'package:hyella_telehealth/data/repository/entities/contact_entity.dart';
import 'package:hyella_telehealth/presentation/widgets/toast_info.dart';
import 'package:meta/meta.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatContactListLoading()) {
    on<LoadContactListEvent>((event, emit) => event.fetContactList(emit));
  }
}
