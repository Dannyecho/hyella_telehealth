// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'form_builder_bloc.dart';

class FormBuilderState {
  final Map<String, EndpointFormFields> formData;
  FormBuilderState({
    this.formData = const {},
  });

  FormBuilderState copyWith({
    Map<String, EndpointFormFields>? formData,
  }) {
    return FormBuilderState(
      formData: formData ?? this.formData,
    );
  }
}
