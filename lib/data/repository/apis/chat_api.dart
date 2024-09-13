import 'package:flutter/material.dart';
import 'package:hyella_telehealth/core/constants/app_constants.dart';
import 'package:hyella_telehealth/core/utils/app_util.dart';
import 'package:hyella_telehealth/core/utils/http_util.dart';
import 'package:hyella_telehealth/data/repository/entities/appointment_booking_confirmation_entity.dart';
import 'package:hyella_telehealth/data/repository/entities/appointment_invoice_entity.dart';
import 'package:hyella_telehealth/data/repository/entities/appointment_specialty_fields.dart';
import 'package:hyella_telehealth/presentation/widgets/toast_info.dart';
import 'package:intl/intl.dart';

class ChatApi {
  Future<AppointmentSpecialtyFields?> getPatientPreviousChats(
      String recieverId) async {
    try {
      String publicKey = AppUtil.generateMd5ForApiAuth("app_list_of_doctors");
      String uri =
          "&nwp_request=app_list_of_doctors&token=${AppConstants.token}&public_key=$publicKey&doctor_id=$recieverId";

      var response = await HttpUtil().post(uri);
      if (response is Map && response.containsKey('data')) {
        return AppointmentSpecialtyFields.fromJson(response["data"]);
      }
    } catch (e) {
      print("Error retrieving doctor list from api");
    }
    return null;
  }

  Future<AppointmentSpecialtyFields?> getVenueAndLocation(
      {required String specialty,
      required String doctorId,
      required String dependentId}) async {
    try {
      String publicKey =
          AppUtil.generateMd5ForApiAuth("get_venue_and_location");
      String uri =
          "&nwp_request=app_list_of_doctors2&token=${AppConstants.token}&public_key=$publicKey&specialty_key=$specialty&doctor_id=$doctorId&dependent_id=$dependentId&";

      var response = await HttpUtil().post(uri);
      if (response is Map && response.containsKey('data')) {
        return AppointmentSpecialtyFields.fromJson(response["data"]);
      }
    } catch (e) {
      print("Error retrieving doctor list from api");
    }
    return null;
  }

  Future<AppointmentSpecialtyFields?> getDateTimeSlot({
    required String specialty,
    required String doctorId,
    required String dependentId,
    required String location,
    required DateTime date,
  }) async {
    try {
      String publicKey = AppUtil.generateMd5ForApiAuth("get_date_time_slot");
      String formattedDate = DateFormat("yyyy-MM-dd").format(date);
      String uri =
          "&nwp_request=app_list_of_doctors3&token=${AppConstants.token}&public_key=$publicKey&specialty_key=$specialty&doctor_id=$doctorId&dependent_id=$dependentId&date=$formattedDate&location_id=$location";

      print(uri);
      var response = await HttpUtil().post(uri);
      if (response is Map && response.containsKey('data')) {
        return AppointmentSpecialtyFields.fromJson(response["data"]);
      }
    } catch (e) {
      print("Error retrieving doctor list from api");
    }
    return null;
  }

  Future<AppointmentInvoiceEntity?> getAppointmentInvoice({
    required String specialty,
    required String doctorId,
    required String dependentId,
    required String location,
    required DateTime date,
    required String timeslot,
  }) async {
    try {
      String publicKey = AppUtil.generateMd5ForApiAuth("get_date_time_slot");
      String formattedDate = DateFormat("yyyy-MM-dd").format(date);
      String uri =
          "&nwp_request=app_list_of_doctors4&token=${AppConstants.token}&public_key=$publicKey&specialty_key=$specialty&doctor_id=$doctorId&dependent_id=$dependentId&date=$formattedDate&location_id=$location&time=$timeslot";

      var response = await HttpUtil().post(uri);
      if (response is Map && response.containsKey('data')) {
        return AppointmentInvoiceEntity.fromJson(response["data"]);
      }
    } catch (e) {
      print("Error retrieving doctor list from api");
    }
    return null;
  }

  Future<AppointmentBookingConfirmationEntity?>? bookAppointment(
      {doctorId, ref}) async {
    try {
      String publicKey = AppUtil.generateMd5ForApiAuth("book_appointment");
      String uri =
          "&appointment_ref=$ref&nwp_request=app_list_save&token=${AppConstants.token}&public_key=$publicKey&default=default&action=nwp_health&todo=execute&nwp_action=tele_health_connect&nwp_todo=process_request&development_mode_off=1";

      var response = await HttpUtil().post(uri);
      if (response is Map<String, dynamic> && response.containsKey('data')) {
        var a = AppointmentBookingConfirmationEntity.fromJson(response['data']);
        return a;
      }
      return null;
    } catch (e) {
      toastInfo(
          msg: "Error occured while booking appointment. Please, try again",
          backgroundColor: Colors.red);
    }
    return null;
  }
}
