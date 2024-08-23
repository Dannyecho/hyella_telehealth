// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'appointment_bloc.dart';

abstract class AppointmentEvent {}

class SetAppointmentDepartment extends AppointmentEvent {
  SelectOptionEntity? department;
  SetAppointmentDepartment({
    required this.department,
  });
}

class SetAppointmentDoctor extends AppointmentEvent {
  SelectOptionEntity? doctor;
  SetAppointmentDoctor({
    required this.doctor,
  });
}

class SetAppointmentLocation extends AppointmentEvent {
  SelectOptionEntity? location;
  SetAppointmentLocation({
    required this.location,
  });
}

class SetAppointmentDate extends AppointmentEvent {
  DateTime? date;
  SetAppointmentDate({
    required this.date,
  });
}

class SetAppointmentTime extends AppointmentEvent {
  SelectOptionEntity? time;
  SetAppointmentTime({
    required this.time,
  });
}

class SetAppointmentComment extends AppointmentEvent {
  String? comment;
  SetAppointmentComment({
    required this.comment,
  });
}

class SetRescheduleAppointment extends AppointmentEvent {
  ScheduleEntityData schedule;
  SetRescheduleAppointment({
    required this.schedule,
  });
}

class ResetTime extends AppointmentEvent {}
