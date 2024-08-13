part of 'form_builder_bloc.dart';

abstract class FormBuilderEvent {}

class RegisterFormField extends FormBuilderEvent {
  final Map<String, EndpointFormFields> formData;
  RegisterFormField({required this.formData});
}

class SetField extends FormBuilderEvent {
  final String key;
  final dynamic value;

  SetField({required this.key, required this.value});
}
