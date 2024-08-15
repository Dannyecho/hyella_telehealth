import 'package:bloc/bloc.dart';
import 'package:hyella_telehealth/data/repository/apis/schedule_appointment_api.dart';
import 'package:hyella_telehealth/data/repository/entities/appointment_invoice_entity.dart';
import 'package:hyella_telehealth/data/repository/entities/appointment_specialty_fields.dart';
import 'package:hyella_telehealth/data/repository/entities/select_option_entity.dart';
import 'package:hyella_telehealth/logic/bloc/appointment_bloc.dart';

part 'appointment_step_event.dart';
part 'appointment_step_state.dart';

class AppointmentStepBloc
    extends Bloc<AppointmentStepEvent, AppointmentStepState> {
  AppointmentStepBloc() : super(AppointmentStepState(timeSlot: [])) {
    on<GetSpecialistData>((event, emit) async {
      var response =
          await ScheduleAppointmentApi().getSpecialists(event.service);
      emit(state.copyWith(
        service: event.service,
        doctor: response?.listOption,
        department: response?.dependentListOption,
        specialtyFields: response,
      ));
    });

    on<GetVenueLocations>((event, emit) async {
      var response = await ScheduleAppointmentApi().getVenueAndLocation(
        specialty: state.service!,
        doctorId: event.doctorID,
        dependentId: event.dependentID ?? '',
      );
      print(response.toString());
      emit(state.copyWith(
        location: response!.listOption,
        locationFields: response,
      ));
    });

    on<NextStepEvent>((event, emit) {
      emit(state.copyWith(step: state.step + 1));
    });
    on<PreviousStepEvent>((event, emit) {
      emit(state.copyWith(step: state.step - 1));
    });

    on<GetTimeSlot>(
      (event, emit) async {
        print("Before first");
        emit(state.copyWith(
          timeSlot: [],
          timeSlotFields: AppointmentSpecialtyFields(
            fieldLabel: '',
            listOption: [],
            dependentFieldLabel: '',
            dependentListOption: [],
          ),
        ));
        print("After first");
        var response = await ScheduleAppointmentApi().getDateTimeSlot(
          specialty: state.service!,
          doctorId: event.appointmentState.doctor!.name,
          dependentId: event.appointmentState.department?.name ?? '',
          location: event.appointmentState.location?.name ?? '',
          date: event.dateTime,
        );
        print("Before Second");
        emit(state.copyWith(
          timeSlot: response!.listOption,
          timeSlotFields: response,
        ));
        print("After Second");
      },
    );

    on<GetAppointmentInvoice>(
      (event, emit) async {
        var response = await ScheduleAppointmentApi().getAppointmentInvoice(
          specialty: state.service!,
          doctorId: event.appointmentBloc.state.doctor!.name,
          dependentId: event.appointmentBloc.state.department?.name ?? '',
          location: event.appointmentBloc.state.location?.name ?? '',
          date: event.appointmentBloc.state.date!,
          timeslot: event.appointmentBloc.state.time?.name ?? '',
        );

        emit(
          state.copyWith(
            invoiceFields: response?.tableRow,
            appointmentRef: response?.appointmentRef,
          ),
        );
      },
    );

    on<ResetTimeSlot>(
      (event, emit) async {
        emit(state.copyWith(timeSlot: null, timeSlotFields: null));
        event.appointmentBloc.add(ResetTime());
      },
    );
  }
}
