import 'package:bloc/bloc.dart';
import 'package:hyella_telehealth/data/repository/entities/schedule_entity.dart';
import 'dart:convert';

import 'package:hyella_telehealth/data/repository/entities/select_option_entity.dart';
part 'appointment_event.dart';
part 'appointment_state.dart';

class AppointmentBloc extends Bloc<AppointmentEvent, AppointmentState> {
  AppointmentBloc() : super(AppointmentState()) {
    on<SetAppointmentDepartment>((event, emit) {
      emit(state.copyWith(department: event.department));
    });

    on<SetAppointmentDoctor>((event, emit) {
      emit(state.copyWith(doctor: event.doctor));
    });

    on<SetAppointmentLocation>((event, emit) {
      emit(state.copyWith(location: event.location));
    });

    on<SetAppointmentDate>((event, emit) {
      emit(state.copyWith(date: event.date));
    });

    on<SetAppointmentTime>((event, emit) {
      emit(state.copyWith(time: event.time));
    });

    on<SetAppointmentComment>((event, emit) {
      emit(state.copyWith(comment: event.comment));
    });
    on<ResetTime>((event, emit) {
      emit(state.copyWith(time: SelectOptionEntity(name: '', value: '')));
    });
    on<SetRescheduleAppointment>((event, emit) {
      emit(AppointmentState(
        department: SelectOptionEntity(
            name: event.schedule.title!, value: event.schedule.doctorId!),
        doctor: SelectOptionEntity(
            name: event.schedule.receiverId!,
            value: event.schedule.receiverId!),
      ));
    });
  }
}
