// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'profile_edit_bloc.dart';

enum ProfileImageSource { web, file, none }

class ProfileEditState {
  String profileImage;
  ProfileImageSource source;
  bool isLoading;
  ProfileEditState({
    required this.profileImage,
    required this.source,
    required this.isLoading,
  });

  ProfileEditState copyWith({
    String? profileImage,
    ProfileImageSource? source,
    bool? isLoading,
  }) {
    return ProfileEditState(
      profileImage: profileImage ?? this.profileImage,
      source: source ?? this.source,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
