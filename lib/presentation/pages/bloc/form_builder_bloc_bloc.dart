import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'form_builder_bloc_event.dart';
part 'form_builder_bloc_state.dart';

class FormBuilderBlocBloc extends Bloc<FormBuilderBlocEvent, FormBuilderBlocState> {
  FormBuilderBlocBloc() : super(FormBuilderBlocInitial()) {
    on<FormBuilderBlocEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
