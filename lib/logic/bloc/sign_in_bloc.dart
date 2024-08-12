import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hyella_telehealth/logic/bloc/sign_in_event.dart';
import 'package:hyella_telehealth/logic/bloc/sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc() : super(SignInState(userType: 'user_mgt_login')) {
    on<EmailEvent>(_emailEvent);
    on<PasswordEvent>(_passwordEvent);
    on<IsStaffEvent>(_isStaffEvent);
    on<FcmTokenEvent>(_fcmTokenEvent);
  }

  void _emailEvent(EmailEvent event, Emitter<SignInState> emit) {
    emit(state.copyWith(email: event.email));
  }

  void _passwordEvent(PasswordEvent event, Emitter<SignInState> emit) {
    emit(state.copyWith(password: event.password));
  }

  void _isStaffEvent(IsStaffEvent event, Emitter<SignInState> emit) {
    String userType = 'user_mgt_login';
    if (event.isStaff) {
      userType = 'user_mgts_login';
    }
    emit(state.copyWith(isStaff: event.isStaff, userType: userType));
  }

  void _fcmTokenEvent(FcmTokenEvent event, Emitter<SignInState> emit) {
    emit(state.copyWith(fcmToken: event.fcmToken));
  }
}
