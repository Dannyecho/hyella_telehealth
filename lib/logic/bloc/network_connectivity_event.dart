part of 'network_connectivity_bloc.dart';

abstract class NetworkConnectivityEvent {}

class ChangeConnectionEvent extends NetworkConnectivityEvent {
  final List<ConnectivityResult> connectivity;

  ChangeConnectionEvent({required this.connectivity});
}
