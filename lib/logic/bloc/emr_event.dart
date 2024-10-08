// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'emr_bloc.dart';

abstract class EmrEvent {}

class FetchingEmrOptionsEvent extends EmrEvent {
  final String pageKey;
  FetchingEmrOptionsEvent({
    required this.pageKey,
  });
}

class SetEmrOptionsEvent extends EmrEvent {
  final List<EmrOptionsDatum> options;
  SetEmrOptionsEvent({
    required this.options,
  });
}

class EmptyAllEmrOptionsEvent extends EmrEvent {}
