import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hyella_telehealth/core/constants/app_colors.dart';
import 'package:hyella_telehealth/data/repository/apis/schedule_appointment_api.dart';
import 'package:hyella_telehealth/data/repository/entities/appointment_booking_confirmation_entity.dart';

class AppointmentController {
  AppointmentController();
  Future<AppointmentBookingConfirmationEntity?> bookAppointment(context,
      {doctorId, appointment_ref}) async {
    try {
      return await ScheduleAppointmentApi()
          .bookAppointment(doctorId: doctorId, ref: appointment_ref);

      /* if (response?.type == 0) {
        EasyLoading.dismiss();
        toastInfo(msg: response!.msg);
      }
      print(response?.data.runtimeType);
      AppointmentBookingConfirmationEntity bookingConfirmation =
          AppointmentBookingConfirmationEntity.fromJson(response?.data);
      EasyLoading.dismiss();
      Navigator.popAndPushNamed(
        context,
        AppRoute.webView,
        arguments: {
          'title': bookingConfirmation.urlTitle,
          'url': bookingConfirmation.url
        },
      ); */
    } catch (e) {
      EasyLoading.dismiss();
    }
    return null;
  }

  /* Future<List<String>> getDoctorList(String query) async {
    print(specialist);
    print(query);
    var response = await ScheduleAppointmentApi().getDoctor(specialist, query);
    print(response);
    print(query);
    return response;
  } */
}
