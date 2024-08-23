// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'schedule_bloc.dart';

abstract class ScheduleState {}

final class ScheduleLoading extends ScheduleState {}

final class ScheduleLoaded extends ScheduleState {
  final List<ScheduleEntityData>? upComingSchedules;
  final List<ScheduleEntityData>? completedSchedules;
  final List<ScheduleEntityData>? cancelledSchedules;

  ScheduleLoaded(
      {this.upComingSchedules,
      this.completedSchedules,
      this.cancelledSchedules});

  ScheduleLoaded copyWith({
    List<ScheduleEntityData>? upComingSchedules,
    List<ScheduleEntityData>? completedSchedules,
    List<ScheduleEntityData>? cancelledSchedules,
  }) {
    return ScheduleLoaded(
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
