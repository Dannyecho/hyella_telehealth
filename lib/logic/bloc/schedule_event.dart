part of 'schedule_bloc.dart';

abstract class ScheduleEvent {}

class LoadUpComingScheduleEvent extends ScheduleEvent {}

class LoadCompletedScheduleEvent extends ScheduleEvent {}

class LoadCancelledScheduleEvent extends ScheduleEvent {}
