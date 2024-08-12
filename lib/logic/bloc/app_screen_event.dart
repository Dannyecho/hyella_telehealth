part of 'app_screen_bloc.dart';

final class AppScreenEvent {}

final class SwitchScreen extends AppScreenEvent {
  int index;
  SwitchScreen({required this.index});
}
