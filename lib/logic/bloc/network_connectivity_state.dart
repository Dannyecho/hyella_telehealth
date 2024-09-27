// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'network_connectivity_bloc.dart';

class NetworkConnectivityState {
  final List<ConnectivityResult> connectivity;
  NetworkConnectivityState({required this.connectivity});

  NetworkConnectivityState copyWith({
    List<ConnectivityResult>? connectivity,
  }) {
    return NetworkConnectivityState(
      connectivity: connectivity ?? this.connectivity,
    );
  }
}
