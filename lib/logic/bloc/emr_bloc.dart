import 'package:bloc/bloc.dart';
import 'package:hyella_telehealth/data/repository/apis/emr_api.dart';
import 'package:hyella_telehealth/data/repository/entities/emr_options.dart';
import 'package:hyella_telehealth/presentation/widgets/toast_info.dart';

part 'emr_event.dart';
part 'emr_state.dart';

class EmrBloc extends Bloc<EmrEvent, EmrState> {
  late final EmrOptions options;
  EmrBloc() : super(EmrState(emrOptions: [])) {
    on<FetchingEmrOptionsEvent>((event, emit) async {
      var response = await EmrApi().getEmrOptions();

      if (response['type'] == 0) {
        toastInfo(msg: response['msg']);
        emit(state.copyWith(emrOptions: []));
      } else {
        EmrOptions options = EmrOptions.fromJson(response['data']);
        List<EmrOptionsDatum> emrOptions = options.data;
        emit(EmrState(emrOptions: emrOptions));
      }
    });
  }
}
