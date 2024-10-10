import 'package:bloc/bloc.dart';
import 'package:hyella_telehealth/data/repository/apis/emr_api.dart';
import 'package:hyella_telehealth/data/repository/entities/emr_options.dart';
import 'package:hyella_telehealth/presentation/widgets/toast_info.dart';

part 'emr_event.dart';
part 'emr_state.dart';

class EmrBloc extends Bloc<EmrEvent, EmrState> {
  late final EmrOptions options;
  Map<String, List<EmrOptionsDatum>?> allEmrOptions = {};

  EmrBloc() : super(EmrState(loading: true, emrOptions: [])) {
    on<FetchingEmrOptionsEvent>((event, emit) async {
      emit(state.copyWith(loading: true));
      var response = await EmrApi().getEmrOptions(event.pageKey);

      if (response['type'] == 0) {
        toastInfo(msg: response['msg']);
        emit(state.copyWith(
          emrOptions: [],
          loading: false,
        ));
      } else {
        EmrOptions options = EmrOptions.fromJson(response['data']);
        List<EmrOptionsDatum> emrOptions = options.data;

        allEmrOptions[event.pageKey] = emrOptions;
        emit(state.copyWith(loading: false, emrOptions: emrOptions));
      }
    });
    on<SetEmrOptionsEvent>(
      (event, emit) {
        emit(state.copyWith(emrOptions: event.options));
      },
    );

    on<EmptyAllEmrOptionsEvent>(
      (event, emit) {
        allEmrOptions = {};
      },
    );
  }
}
