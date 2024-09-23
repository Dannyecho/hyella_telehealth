import 'package:bloc/bloc.dart';
part 'profile_edit_event.dart';
part 'profile_edit_state.dart';

class ProfileEditBloc extends Bloc<ProfileEditEvent, ProfileEditState> {
  ProfileEditBloc()
      : super(ProfileEditState(
          profileImage: '',
          source: ProfileImageSource.none,
        )) {
    on<SetProfileImageEvent>((event, emit) {
      emit(state.copyWith(
        profileImage: event.imagePath,
        source: event.source,
      ));
    });

    on<SetProfileSource>((event, emit) {
      emit(state.copyWith(source: event.source));
    });
  }
}
