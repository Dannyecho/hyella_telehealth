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
  ScheduleLoaded loadedState = ScheduleLoaded(
    hasError: false,
    upComingSchedules: [],
    cancelledSchedules: [],
    completedSchedules: [],
  );
  /* List<ScheduleEntityData>? upcoming = [];
  List<ScheduleEntityData>? completed = [];
  List<ScheduleEntityData>? cancelled = []; */

  ScheduleBloc() : super(ScheduleLoading()) {
    on<LoadUpComingScheduleEvent>((event, emit) async {
      emit(ScheduleLoading());
      var response = await ScheduleApi().fetchUpComingSchedules();
      if (response['type'] == 0) {
        toastInfo(msg: response['msg']);
        if ((response['data'] as Map).containsKey('app_list') &&
            (response['data']['app_list']['upcoming'] as Map).isEmpty) {
          emit(
            loadedState.copyWith(hasError: false),
          );
        } else {
          emit(loadedState.copyWith(hasError: true));
        }
      } else {
        scheduleEntity = ScheduleEntity.fromJson(response['data']);
        loadedState = loadedState.copyWith(
          upComingSchedules: scheduleEntity.appList?.upcoming?.values.toList(),
        );

        emit(loadedState);

        add(LoadCompletedScheduleEvent());
        add(LoadCancelledScheduleEvent());
      }
    });

    on<LoadCompletedScheduleEvent>(
      (event, emit) async {
        emit(ScheduleLoading());
        var response = await ScheduleApi().fetchCompletedSchedules();
        if (response['type'] == 0) {
          toastInfo(msg: response['msg']);
          if ((response['data'] as Map).containsKey('app_list') &&
              (response['data']['app_list']['completed'] as Map).isEmpty) {
            emit(
              loadedState.copyWith(hasError: false),
            );
          } else {
            emit(loadedState.copyWith(hasError: true));
          }
        } else {
          try {
            scheduleEntity = ScheduleEntity.fromJson(response['data']);
            loadedState = loadedState.copyWith(
                hasError: false,
                completedSchedules:
                    scheduleEntity.appList?.completed?.values.toList());
            emit(loadedState);
          } catch (e) {
            emit(
              loadedState.copyWith(hasError: true),
            );
          }
        }
      },
    );

    on<LoadCancelledScheduleEvent>(
      (event, emit) async {
        emit(ScheduleLoading());
        var response = await ScheduleApi().fetchCancelledSchedules();
        if (response['type'] == 0) {
          toastInfo(msg: response['msg']);
          if ((response['data'] as Map).containsKey('app_list') &&
              (response['data']['app_list']['cancelled'] as Map).isEmpty) {
            emit(
              loadedState.copyWith(hasError: false),
            );
          } else {
            emit(loadedState.copyWith(hasError: true));
          }
        } else {
          scheduleEntity = ScheduleEntity.fromJson(response['data']);
          loadedState = loadedState.copyWith(
            cancelledSchedules:
                scheduleEntity.appList?.cancelled?.values.toList(),
          );

          emit(loadedState);
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
