part of 'app_bloc.dart';

class AppBlocState {
  final Data? appData;
  final User? user;

  const AppBlocState({this.appData, this.user});

  AppBlocState copyWith({
    Data? appData,
    User? user,
  }) {
    return AppBlocState(
      appData: appData ?? this.appData,
      user: user ?? this.user,
    );
  }
}
