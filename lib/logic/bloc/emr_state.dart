// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'emr_bloc.dart';

class EmrState {
  List<EmrOptionsDatum?> emrOptions;
  EmrState({
    required this.emrOptions,
  });

  EmrState copyWith({
    List<EmrOptionsDatum>? emrOptions,
  }) {
    return EmrState(
      emrOptions: emrOptions ?? this.emrOptions,
    );
  }
}
