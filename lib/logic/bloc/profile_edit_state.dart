// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'profile_edit_bloc.dart';

enum ProfileImageSource { web, file, none }

class ProfileEditState {
  final String profileImage;
  final ProfileImageSource source;
  final bool isLoading;
  final bool refreshApp;

  ProfileEditState({
    required this.profileImage,
    required this.source,
    required this.isLoading,
    required this.refreshApp,
  });

  ProfileEditState copyWith({
    String? profileImage,
    ProfileImageSource? source,
    bool? isLoading,
    bool? refreshApp,
  }) {
    return ProfileEditState(
      profileImage: profileImage ?? this.profileImage,
      source: source ?? this.source,
      isLoading: isLoading ?? this.isLoading,
      refreshApp: refreshApp ?? this.refreshApp,
    );
  }
}
