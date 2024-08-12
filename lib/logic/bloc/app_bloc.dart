import 'package:bloc/bloc.dart';
import 'package:hyella_telehealth/data/repository/entities/login_response_entity.dart';

part 'app_bloc_event.dart';
part 'app_bloc_state.dart';

class AppBloc extends Bloc<AppBlocEvent, AppBlocState> {
  AppBloc() : super(const AppBlocState(appData: null)) {
    on<SetAppDataEvent>((event, emit) {
      emit(state.copyWith(appData: event.appData));
    });

    on<SetUserEvent>((event, emit) {
      emit(state.copyWith(user: event.user));
    });
  }
}
