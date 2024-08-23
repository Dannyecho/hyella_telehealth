import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hyella_telehealth/data/repository/apis/schedule_api.dart';
import 'package:hyella_telehealth/data/repository/entities/schedule_entity.dart';
import 'package:hyella_telehealth/presentation/widgets/toast_info.dart';

part 'schedule_event.dart';
part 'schedule_state.dart';

class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  late ScheduleEntity scheduleEntity;
  List<ScheduleEntityData>? upcoming;
  List<ScheduleEntityData>? completed;
  List<ScheduleEntityData>? cancelled;

  ScheduleBloc() : super(ScheduleLoading()) {
    on<LoadUpComingScheduleEvent>((event, emit) async {
      emit(ScheduleLoading());
      var response = await ScheduleApi().fetchUpComingSchedules();
      if (response['type'] == 'error') {
        toastInfo(msg: response['msg'], backgroundColor: Colors.red);
        emit(ScheduleLoaded());
      } else {
        scheduleEntity = ScheduleEntity.fromJson(response['data']);
        upcoming = scheduleEntity.appList?.upcoming?.values.toList();
        emit(ScheduleLoaded(
            upComingSchedules: upcoming,
            completedSchedules: completed,
            cancelledSchedules: cancelled));

        add(LoadCompletedScheduleEvent());
        add(LoadCancelledScheduleEvent());
      }
    });

    on<LoadCompletedScheduleEvent>(
      (event, emit) async {
        emit(ScheduleLoading());
        var response = await ScheduleApi().fetchCompletedSchedules();
        if (response['type'] == 'error') {
          toastInfo(msg: response['msg'], backgroundColor: Colors.red);
          emit(ScheduleLoaded());
        } else {
          scheduleEntity = ScheduleEntity.fromJson(response['data']);
          completed = scheduleEntity.appList?.completed?.values.toList();
          emit(ScheduleLoaded(
              upComingSchedules: upcoming,
              completedSchedules: completed,
              cancelledSchedules: cancelled));
        }
      },
    );

    on<LoadCancelledScheduleEvent>(
      (event, emit) async {
        emit(ScheduleLoading());
        var response = await ScheduleApi().fetchCancelledSchedules();
        if (response['type'] == 'error') {
          toastInfo(msg: response['msg'], backgroundColor: Colors.red);
          emit(ScheduleLoaded());
        } else {
          scheduleEntity = ScheduleEntity.fromJson(response['data']);
          cancelled = scheduleEntity.appList?.cancelled?.values.toList();
          emit(ScheduleLoaded(
              upComingSchedules: upcoming,
              completedSchedules: completed,
              cancelledSchedules: cancelled));
        }
      },
    );

    on<CancelAppointmentEvent>((event, emit) async {
      EasyLoading.show(
        indicator: const CircularProgressIndicator(),
        maskType: EasyLoadingMaskType.clear,
        dismissOnTap: true,
      );

      var response = await ScheduleApi().cancelAppointment(event.ref);
      Color etype = Colors.green;
      if (response['type'] == 0) {
        etype = Colors.red;
      }

      EasyLoading.dismiss();
      toastInfo(msg: response['msg'], backgroundColor: etype);
      add(LoadUpComingScheduleEvent());
    });
  }
}
