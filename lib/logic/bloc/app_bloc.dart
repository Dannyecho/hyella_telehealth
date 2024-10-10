import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:hyella_telehealth/core/constants/app_constants.dart';
import 'package:hyella_telehealth/core/global.dart';
import 'package:hyella_telehealth/data/repository/apis/auth_api.dart';
import 'package:hyella_telehealth/data/repository/entities/login_response_entity.dart';
import 'package:hyella_telehealth/presentation/widgets/toast_info.dart';

part 'app_bloc_event.dart';
part 'app_bloc_state.dart';

class AppBloc extends Bloc<AppBlocEvent, AppBlocState> {
  AppBloc() : super(const AppBlocState(appData: null)) {
    on<SetAppDataEvent>((event, emit) {
      Global.storageService.setString(
          AppConstants.STORAGE_APP_DATA, jsonEncode(event.appData.toJson()));
      emit(state.copyWith(appData: event.appData));
    });

    on<SetUserEvent>((event, emit) {
      Global.storageService.setString(AppConstants.STORAGE_USER_PROFILE_KEY,
          jsonEncode(event.user.toJson()));
      emit(state.copyWith(user: event.user));
    });

    on<UpdateUserInfoEvent>(
      (event, emit) async {
        var response = await AuthApi().updateUserInfo(state.user!.isStaff == 1);
        if (response.type == 0) {
          toastInfo(msg: response.msg!);
          return;
        }

        add(SetAppDataEvent(appData: response.data!));
        // add(SetUserEvent(user: response.data!.user!));
      },
    );
  }
}
