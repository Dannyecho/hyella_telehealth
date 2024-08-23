import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hyella_telehealth/data/repository/apis/emr_api.dart';
import 'package:hyella_telehealth/data/repository/entities/lab_result_entity.dart';
import 'package:hyella_telehealth/presentation/widgets/toast_info.dart';

part 'lab_result_event.dart';
part 'lab_result_state.dart';

class LabResultBloc extends Bloc<LabResultEvent, LabResultState> {
  late LabResultEntity _labResultEntity;
  LabResultBloc() : super(LabResultInitial()) {
    on<FetchLabResultsEvent>((event, emit) async {
      var response = await EmrApi().getLabResults();
      if (response['type'] == 0) {
        toastInfo(msg: response['msg'], backgroundColor: Colors.red);
        emit(LabResultLoadedState(labResults: const []));
      } else {
        _labResultEntity = LabResultEntity.fromJson(response['data']);
        emit(LabResultLoadedState(labResults: _labResultEntity.data));
      }
    });
  }
}
