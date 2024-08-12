part of 'app_bloc.dart';

abstract class AppBlocEvent {}

class SetAppDataEvent extends AppBlocEvent {
  final Data appData;
  SetAppDataEvent({required this.appData});
}

class SetUserEvent extends AppBlocEvent {
  final User user;
  SetUserEvent({required this.user});
}
