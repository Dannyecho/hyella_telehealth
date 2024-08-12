import 'package:bloc/bloc.dart';
import 'package:hyella_telehealth/data/repository/entities/endpoint_entity.dart';

part 'endpoint_event.dart';
part 'endpoint_state.dart';

class EndpointBloc extends Bloc<EndpointEvent, EndpointState> {
  EndpointBloc() : super(const EndpointState()) {
    on<TriggerEndpoint>((event, emit) {
      emit(EndpointState(endPointEntity: event.endPointEntity));
    });
  }
}
