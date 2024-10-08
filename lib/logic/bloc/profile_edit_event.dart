// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'profile_edit_bloc.dart';

abstract class ProfileEditEvent {}

class SetProfileImageEvent extends ProfileEditEvent {
  final String imagePath;
  final ProfileImageSource source;
  SetProfileImageEvent({
    required this.imagePath,
    required this.source,
  });
}

class UpdateProfileImageEvent extends ProfileEditEvent {
  final String imagePath;
  final ProfileImageSource source;
  final BuildContext context;
  UpdateProfileImageEvent({
    required this.imagePath,
    required this.source,
    required this.context,
  });
}

class SetProfileSource extends ProfileEditEvent {
  ProfileImageSource source;
  SetProfileSource({
    required this.source,
  });
}
