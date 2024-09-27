import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

part 'network_connectivity_event.dart';
part 'network_connectivity_state.dart';

class NetworkConnectivityBloc
    extends Bloc<NetworkConnectivityEvent, NetworkConnectivityState> {
  NetworkConnectivityBloc()
      : super(
          NetworkConnectivityState(
            connectivity: [ConnectivityResult.other],
          ),
        ) {
    Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> result) {
      // Received changes in available connectivity types!
      // Display a Snackbar on connectivity change
      add(ChangeConnectionEvent(connectivity: result));
    });

    on<ChangeConnectionEvent>((event, emit) {
      emit(NetworkConnectivityState(connectivity: event.connectivity));
    });
  }
}
