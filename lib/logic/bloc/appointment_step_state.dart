// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'appointment_step_bloc.dart';

class AppointmentStepState {
  final int step;
  final String? service;
  final String? appointmentRef;
  final List<SelectOptionEntity>? doctor;
  final List<SelectOptionEntity>? department;
  final List<SelectOptionEntity>? location;
  final List<SelectOptionEntity>? timeSlot;
  final AppointmentSpecialtyFields? specialtyFields;
  final AppointmentSpecialtyFields? locationFields;
  final AppointmentSpecialtyFields? timeSlotFields;
  final InvoiceTableRow? invoiceFields;

  const AppointmentStepState({
    this.step = 0,
    this.service,
    this.doctor,
    this.department,
    this.location,
    this.timeSlot,
    this.specialtyFields,
    this.locationFields,
    this.timeSlotFields,
    this.invoiceFields,
    this.appointmentRef,
  });

  AppointmentStepState copyWith({
    int? step,
    String? service,
    List<SelectOptionEntity>? doctor,
    List<SelectOptionEntity>? department,
    List<SelectOptionEntity>? location,
    List<SelectOptionEntity>? timeSlot,
    AppointmentSpecialtyFields? specialtyFields,
    AppointmentSpecialtyFields? locationFields,
    AppointmentSpecialtyFields? timeSlotFields,
    InvoiceTableRow? invoiceFields,
    String? appointmentRef,
  }) {
    return AppointmentStepState(
      step: step ?? this.step,
      service: service ?? this.service,
      doctor: doctor ?? this.doctor,
      department: department ?? this.department,
      location: location ?? this.location,
      timeSlot: timeSlot ?? this.timeSlot,
      specialtyFields: specialtyFields ?? this.specialtyFields,
      locationFields: locationFields ?? this.locationFields,
      timeSlotFields: timeSlotFields ?? this.timeSlotFields,
      invoiceFields: invoiceFields ?? this.invoiceFields,
      appointmentRef: appointmentRef ?? this.appointmentRef,
    );
  }

  bool get isLastStep => step == 2;
}

class LoadingState extends AppointmentStepState {}
