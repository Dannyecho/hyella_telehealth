import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hyella_telehealth/logic/bloc/welcome_event.dart';
import 'package:hyella_telehealth/logic/bloc/welcome_state.dart';

class WelcomeBloc extends Bloc<WelcomeEvent, WelcomeState> {
  WelcomeBloc() : super(WelcomeState(slideIndex: 0)) {
    on<WelcomeEvent>((event, emit) {
      emit(WelcomeState(slideIndex: state.slideIndex));
    });
  }
}
