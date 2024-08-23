import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hyella_telehealth/core/constants/app_colors.dart';
import 'package:hyella_telehealth/core/constants/app_colors2.dart';
import 'package:hyella_telehealth/data/repository/entities/appointment_specialty_fields.dart';
import 'package:hyella_telehealth/data/repository/entities/login_response_entity.dart';
import 'package:hyella_telehealth/data/repository/entities/schedule_entity.dart';
import 'package:hyella_telehealth/data/repository/entities/select_option_entity.dart';
import 'package:hyella_telehealth/logic/bloc/appointment_bloc.dart';
import 'package:hyella_telehealth/logic/bloc/appointment_step_bloc.dart';
import 'package:hyella_telehealth/logic/controllers/appointment_controller.dart';
import 'package:hyella_telehealth/presentation/route/app_route.dart';
import 'package:hyella_telehealth/presentation/widgets/toast_info.dart';
import 'package:intl/intl.dart';

class ScheduleAppointment extends StatefulWidget {
  const ScheduleAppointment(
      {super.key, required this.service, this.rescheduling});
  final Service service;
  final ScheduleEntityData? rescheduling;

  @override
  State<ScheduleAppointment> createState() => _ScheduleAppointmentState();
}

class _ScheduleAppointmentState extends State<ScheduleAppointment> {
  int currentStep = 0;
  late List<SelectOptionEntity>? _doctorList;
  late List<SelectOptionEntity>? _departmentList;
  late List<SelectOptionEntity>? _locationList;
  late List<SelectOptionEntity>? _timeSlotList;
  // late AppointmentSpecialtyFields? _specialtyFields;
  late AppointmentSpecialtyFields? _locationListFields;
  late AppointmentSpecialtyFields? _timeSlotListFields;
  late AppointmentBloc _appointmentBloc;
  late AppointmentStepBloc _appointmentStepBloc;

  SelectOptionEntity? _initialDepartment = null;
  SelectOptionEntity? _initialTime = null;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    /*  if (widget.rescheduling != null) {
      context
          .read<AppointmentBloc>()
          .add(SetRescheduleAppointment(schedule: widget.rescheduling!));
    } */
    context
        .read<AppointmentStepBloc>()
        .add(GetSpecialistData(service: widget.service.key!));
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? selectedDate = _appointmentBloc.state.date;
    if (_appointmentBloc.state.location == null) {
      toastInfo(
        msg: "Please select your location of appointment",
        backgroundColor: Colors.red,
      );
      return;
    }

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _appointmentBloc.state.date ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      selectableDayPredicate: (DateTime date) {
        return date.isAfter(DateTime.now().subtract(const Duration(days: 1)));
      },
    );

    if (picked != null && picked != selectedDate) {
      _initialTime = null;
      _appointmentBloc.add(SetAppointmentDate(date: picked));
      _appointmentStepBloc
          .add(ResetTimeSlot(appointmentBloc: _appointmentBloc));
      _appointmentStepBloc.add(GetTimeSlot(
          appointmentState: _appointmentBloc.state, dateTime: picked));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.service.title!,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: BlocBuilder<AppointmentStepBloc, AppointmentStepState>(
          builder: (context, state) {
            _appointmentBloc = context.watch<AppointmentBloc>();
            _appointmentStepBloc = context.read<AppointmentStepBloc>();

            _doctorList = state.doctor;
            _departmentList = state.department;
            _locationList = state.location;
            _timeSlotList = state.timeSlot;

            // _specialtyFields = state.specialtyFields;
            _locationListFields = state.locationFields;
            _timeSlotListFields = state.timeSlotFields;

            _initialDepartment = _appointmentBloc.state.department;
            _initialTime = _appointmentBloc.state.time;

            return (state.doctor == null)
                ? const Center(child: CircularProgressIndicator())
                : Stepper(
                    elevation: 16,
                    currentStep: state.step,
                    steps: [
                      Step(
                        isActive: state.step >= 0,
                        title: const Text("Request Investigation"),
                        content: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(state.specialtyFields!.fieldLabel!),
                            CustomDropdown<SelectOptionEntity>(
                              hintText: state.specialtyFields!.fieldLabel!,
                              initialItem: _appointmentBloc.state.doctor,
                              items: _doctorList,
                              onChanged: (value) {
                                _appointmentBloc
                                    .add(SetAppointmentDoctor(doctor: value!));
                                _appointmentStepBloc.add(GetVenueLocations(
                                    doctorID: value.name,
                                    dependentID: _appointmentBloc
                                        .state.department?.value));
                              },
                            ),
                            const Divider(
                              height: 20,
                            ),
                            Text(state.specialtyFields!.dependentFieldLabel!),
                            CustomDropdown<SelectOptionEntity>(
                              hintText:
                                  state.specialtyFields!.dependentFieldLabel!,
                              initialItem: _initialDepartment,
                              items: _departmentList,
                              onChanged: (value) {
                                _appointmentBloc.add(SetAppointmentDepartment(
                                    department: value));
                                print('changing value to: ${value?.name}');
                              },
                            ),
                          ],
                        ),
                      ),
                      Step(
                        isActive: state.step >= 1,
                        title: const Text("Appointment Details"),
                        content: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            if (state.location != null) ...[
                              Text(_locationListFields!.fieldLabel!),
                              CustomDropdown<SelectOptionEntity?>(
                                hintText: _locationListFields?.fieldLabel ?? '',
                                initialItem: _appointmentBloc.state.location,
                                items: _locationList,
                                onChanged: (value) {
                                  _appointmentBloc.add(
                                      SetAppointmentLocation(location: value!));
                                },
                              ),
                              const Divider(
                                height: 20,
                              ),
                              ListTile(
                                leading:
                                    SvgPicture.asset('assets/svg/calendar.svg'),
                                title: Text(_appointmentBloc.state.date != null
                                    ? DateFormat('MMMM dd, yyyy')
                                        .format(_appointmentBloc.state.date!)
                                    : "Tap to choose appointment date"),
                                onTap: () async {
                                  await _selectDate(context);
                                },
                              ),
                              Builder(builder: (context) {
                                if (_appointmentBloc.state.date != null) {
                                  if (_timeSlotList!.isNotEmpty) {
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(_timeSlotListFields!.fieldLabel!),
                                        CustomDropdown<SelectOptionEntity?>(
                                          hintText:
                                              _timeSlotListFields?.fieldLabel ??
                                                  '',
                                          initialItem:
                                              _initialTime!.name.isEmpty
                                                  ? null
                                                  : _initialTime,
                                          items: _timeSlotList,
                                          onChanged: (value) {
                                            _appointmentBloc
                                                .add(SetAppointmentTime(
                                              time: value,
                                            ));
                                            _appointmentStepBloc.add(
                                                GetAppointmentInvoice(
                                                    appointmentBloc:
                                                        _appointmentBloc));
                                          },
                                        ),
                                        const Divider(
                                          height: 40,
                                        ),
                                        TextField(
                                          autocorrect: true,
                                          maxLines: null,
                                          onChanged: (value) {
                                            _appointmentBloc.add(
                                                SetAppointmentComment(
                                                    comment: value));
                                          },
                                          keyboardType: TextInputType.multiline,
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            hintText: 'Remark/Note',
                                          ),
                                        )
                                      ],
                                    );
                                  } else {
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  }
                                }
                                return const SizedBox(
                                  height: 1,
                                );
                              }),
                            ]
                          ],
                        ),
                      ),
                      Step(
                          isActive: state.step >= 1,
                          title: const Text('Invoice'),
                          content:
                              _appointmentStepBloc.state.invoiceFields == null
                                  ? const Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : Column(
                                      children: [
                                        Table(
                                          border: TableBorder.all(
                                            color: AppColors.lightText2,
                                            width: .5,
                                          ),
                                          children: _appointmentStepBloc
                                              .state.invoiceFields!
                                              .toJson()
                                              .entries
                                              .map((invField) {
                                            return TableRow(children: [
                                              Text(
                                                invField.key,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(invField.value),
                                            ]);
                                          }).toList(),
                                        )
                                      ],
                                    ))
                    ],
                    onStepContinue: () async {
                      if (state.isLastStep) {
                        EasyLoading.show(
                          indicator: CircularProgressIndicator(
                            color: AppColors2.color1,
                          ),
                          dismissOnTap: true,
                          maskType: EasyLoadingMaskType.clear,
                        );
                        var result = await AppointmentController()
                            .bookAppointment(context,
                                appointment_ref: state.appointmentRef);
                        EasyLoading.dismiss();
                        Navigator.popAndPushNamed(context, AppRoute.webView,
                            arguments: {
                              'title': result?.urlTitle,
                              'url': result?.url,
                            });
                        /* showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text(
                                    "Are you sure you want to book this appointment?"),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text("Cancel"),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      
                                    },
                                    child: const Text("Book Appointment"),
                                  ),
                                ],
                              );
                            });
                         */

                        return;
                      }

                      AppointmentState appointmentState =
                          _appointmentBloc.state;
                      switch (state.step) {
                        case 0:
                          if (appointmentState.doctor == null) {
                            toastInfo(
                              msg: "Please select a consultant",
                              backgroundColor: Colors.red,
                            );
                            return;
                          }
                          break;
                        case 1:
                          if (appointmentState.location == null) {
                            toastInfo(
                              msg: "Please select appointment location",
                              backgroundColor: Colors.red,
                            );
                            return;
                          }
                          if (appointmentState.date == null) {
                            toastInfo(
                              msg: "Please select date of visit",
                              backgroundColor: Colors.red,
                            );
                            return;
                          }
                          if (appointmentState.time == null) {
                            toastInfo(
                              msg: "Please select a convenient time",
                              backgroundColor: Colors.red,
                            );
                            return;
                          }
                          if (appointmentState.time!.name.isEmpty) {
                            toastInfo(
                              msg: "Sorry! You cannot book this appointment.",
                              backgroundColor: Colors.red,
                            );
                            return;
                          }
                          break;
                        case 2:
                          break;
                      }
                      _appointmentStepBloc.add(NextStepEvent());
                    },
                    onStepCancel: () {
                      if (state.step == 0) {
                        return;
                      }
                      _appointmentStepBloc.add(PreviousStepEvent());
                    },
                  );
          },
        ),
      ),
    );
  }

  List<Step> appointmentSteps() => [
        Step(
          isActive: currentStep >= 1,
          title: const Text("Appointment Details"),
          content: Column(),
        ),
        Step(
          isActive: currentStep >= 2,
          title: const Text("Confirmation & Payment"),
          content: Column(),
        ),
      ];
}
