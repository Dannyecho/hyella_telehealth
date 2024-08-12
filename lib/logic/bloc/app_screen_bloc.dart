import 'package:bloc/bloc.dart';

part 'app_screen_event.dart';
part 'app_screen_state.dart';

class AppScreenBloc extends Bloc<AppScreenEvent, AppScreenState> {
  AppScreenBloc() : super(const AppScreenState(index: 0)) {
    on<SwitchScreen>((event, emit) {
      emit(AppScreenState(index: event.index));
    });
  }
}
