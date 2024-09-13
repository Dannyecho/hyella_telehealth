// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'schedule_bloc.dart';

abstract class ScheduleState {}

final class ScheduleLoading extends ScheduleState {}

final class ScheduleLoaded extends ScheduleState {
  final bool hasError;
  final List<ScheduleEntityData>? upComingSchedules;
  final List<ScheduleEntityData>? completedSchedules;
  final List<ScheduleEntityData>? cancelledSchedules;

  ScheduleLoaded({
    required this.hasError,
    this.upComingSchedules,
    this.completedSchedules,
    this.cancelledSchedules,
  });

  ScheduleLoaded copyWith({
    bool? hasError,
    List<ScheduleEntityData>? upComingSchedules,
    List<ScheduleEntityData>? completedSchedules,
    List<ScheduleEntityData>? cancelledSchedules,
  }) {
    return ScheduleLoaded(
      hasError: hasError ?? this.hasError,
      upComingSchedules: upComingSchedules ?? this.upComingSchedules,
      completedSchedules: completedSchedules ?? this.completedSchedules,
      cancelledSchedules: cancelledSchedules ?? this.cancelledSchedules,
    );
  }
}

final class CancelAppointmentEvent extends ScheduleEvent {
  String ref;
  CancelAppointmentEvent({
    required this.ref,
  });
}
