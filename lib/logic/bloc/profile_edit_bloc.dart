import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hyella_telehealth/data/repository/apis/profile_api.dart';
import 'package:hyella_telehealth/logic/bloc/app_bloc.dart';
import 'package:hyella_telehealth/presentation/widgets/toast_info.dart';
part 'profile_edit_event.dart';
part 'profile_edit_state.dart';

class ProfileEditBloc extends Bloc<ProfileEditEvent, ProfileEditState> {
  ProfileEditBloc()
      : super(ProfileEditState(
          profileImage: '',
          source: ProfileImageSource.none,
          isLoading: false,
        )) {
    on<SetProfileImageEvent>(
      (event, emit) {
        emit(state.copyWith(
          profileImage: event.imagePath,
          source: event.source,
        ));
      },
    );
    on<UpdateProfileImageEvent>((event, emit) async {
      var prevSource = event.source;
      emit(state.copyWith(
        profileImage: event.imagePath,
        source: event.source,
        isLoading: true,
      ));

      var response = await ProfileApi().updateProfilePhoto(event.imagePath);

      if (response.type == 0) {
        emit(
          state.copyWith(
            isLoading: false,
            source: prevSource,
          ),
        );
        toastInfo(msg: response.msg);
        return;
      }

      if (event.context.mounted) {
        // print("Adding profile image");
        event.context.read<AppBloc>().add(UpdateUserInfoEvent());
      }
      toastInfo(msg: response.msg);
      emit(state.copyWith(isLoading: false, source: ProfileImageSource.web));
    });

    on<SetProfileSource>((event, emit) {
      emit(state.copyWith(source: event.source));
    });
  }
}
