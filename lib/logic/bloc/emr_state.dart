// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'emr_bloc.dart';

class EmrState {
  final List<EmrOptionsDatum?> emrOptions;
  final bool loading;
  EmrState({
    required this.emrOptions,
    required this.loading,
  });

  EmrState copyWith({
    List<EmrOptionsDatum>? emrOptions,
    bool? loading,
  }) {
    return EmrState(
      emrOptions: emrOptions ?? this.emrOptions,
      loading: loading ?? this.loading,
    );
  }
}
