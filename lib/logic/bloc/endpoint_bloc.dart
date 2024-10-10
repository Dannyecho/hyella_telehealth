import 'package:bloc/bloc.dart';
import 'package:hyella_telehealth/data/repository/apis/initialize_app_api.dart';
import 'package:hyella_telehealth/data/repository/entities/endpoint_entity.dart';
import 'package:hyella_telehealth/presentation/widgets/toast_info.dart';

part 'endpoint_event.dart';
part 'endpoint_state.dart';

class EndpointBloc extends Bloc<EndpointEvent, EndpointState> {
  EndpointBloc() : super(const EndpointState()) {
    on<TriggerEndpoint>((event, emit) {
      emit(EndpointState(endPointEntity: event.endPointEntity));
    });

    on<RefreshEndpointEvent>(
      (event, emit) async {
        EndPointEntity? result = await InitializeAppApi().fetchAppResource();
        if (result.type == 0) {
          toastInfo(msg: result.msg!);
          return;
        }

        add(TriggerEndpoint(endPointEntity: result));
      },
    );
  }
}
