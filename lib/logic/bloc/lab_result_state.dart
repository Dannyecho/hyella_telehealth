// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'lab_result_bloc.dart';

@immutable
sealed class LabResultState {}

final class LabResultInitial extends LabResultState {}

class LabResultLoadedState extends LabResultState {
  final List<LabResultEntityDatum>? labResults;

  LabResultLoadedState({this.labResults});

  LabResultLoadedState copyWith({
    List<LabResultEntityDatum>? labResults,
  }) {
    return LabResultLoadedState(
      labResults: labResults ?? this.labResults,
    );
  }
}
