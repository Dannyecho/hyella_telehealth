import 'package:bloc/bloc.dart';
import 'package:hyella_telehealth/data/repository/entities/endpoint_entity.dart';

part 'form_builder_event.dart';
part 'form_builder_state.dart';

class FormBuilderBloc extends Bloc<FormBuilderEvent, FormBuilderState> {
  FormBuilderBloc() : super(FormBuilderState()) {
    on<RegisterFormField>((event, emit) {
      emit(state.copyWith(formData: event.formData));
    });
    on<SetField>((event, emit) {
      var nextState = state;
      nextState.formData[event.key]!.value = event.value;
      emit(state.copyWith(formData: nextState.formData));
    });
  }
}
