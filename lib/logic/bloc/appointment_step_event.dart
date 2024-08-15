// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'appointment_step_bloc.dart';

abstract class AppointmentStepEvent {}

class GetSpecialistData extends AppointmentStepEvent {
  String service;
  GetSpecialistData({
    required this.service,
  });
}

class NextStepEvent extends AppointmentStepEvent {}

class PreviousStepEvent extends AppointmentStepEvent {}

class GetVenueLocations extends AppointmentStepEvent {
  String doctorID;
  String? dependentID;

  GetVenueLocations({
    required this.doctorID,
    this.dependentID,
  });
}

class GetTimeSlot extends AppointmentStepEvent {
  AppointmentState appointmentState;
  DateTime dateTime;
  GetTimeSlot({
    required this.appointmentState,
    required this.dateTime,
  });
}

class GetAppointmentInvoice extends AppointmentStepEvent {
  AppointmentBloc appointmentBloc;

  GetAppointmentInvoice({
    required this.appointmentBloc,
  });
}

class ResetTimeSlot extends AppointmentStepEvent {
  AppointmentBloc appointmentBloc;
  ResetTimeSlot({
    required this.appointmentBloc,
  });
}
