import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hyella_telehealth/core/constants/app_colors2.dart';
import 'package:hyella_telehealth/core/utils/app_util.dart';
import 'package:hyella_telehealth/data/repository/entities/login_response_entity.dart';
import 'package:hyella_telehealth/data/repository/entities/schedule_entity.dart';
import 'package:hyella_telehealth/logic/bloc/app_bloc.dart';
import 'package:hyella_telehealth/logic/bloc/schedule_bloc.dart';
import 'package:hyella_telehealth/presentation/route/app_route.dart';

class UpcomingSchedule extends StatefulWidget {
  UpcomingSchedule({Key? key}) : super(key: key);

  @override
  State<UpcomingSchedule> createState() => _UpcomingScheduleState();
}

class _UpcomingScheduleState extends State<UpcomingSchedule> {
  bool cancellingAppointment = false;
  late List<Service>? services;
  late List<ScheduleEntityData>? upcomingSchedules;
  bool hasError = false;
  @override
  void initState() {
    super.initState();

    ScheduleLoaded loaded =
        context.read<ScheduleBloc>().state as ScheduleLoaded;
    if (loaded.hasError) {
      hasError = true;
    } else {
      upcomingSchedules = loaded.upComingSchedules;
      services = context.read<AppBloc>().state.appData?.menu?.home?.data;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScheduleBloc, ScheduleState>(builder: (context, state) {
      return hasError == true
          ? Center(
              child: ElevatedButton(
                onPressed: () {
                  context.read<ScheduleBloc>().add(LoadUpComingScheduleEvent());
                },
                child: const Text("Refresh"),
              ),
            )
          : upcomingSchedules!.isEmpty
              ? Center(
                  child: Text(
                    "You do not have any upcoming appointment\nin your schedule",
                    style: TextStyle(color: AppColors2.color1),
                  ),
                )
              : RefreshIndicator(
                  onRefresh: () async {
                    context
                        .read<ScheduleBloc>()
                        .add(LoadUpComingScheduleEvent());
                  },
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      ScheduleEntityData? schedule = upcomingSchedules?[index];
                      return Container(
                        margin: const EdgeInsets.only(top: 15),
                        child: Card(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(
                                10.0,
                              ),
                              bottomRight: Radius.circular(
                                10.0,
                              ),
                              topRight: Radius.circular(
                                25.0,
                              ),
                              bottomLeft: Radius.circular(
                                10.0,
                              ),
                            ),
                          ),
                          elevation: 3,
                          shadowColor: Colors.black38,
                          color: (AppColors2.color1 as Color).withOpacity(.6),
                          // surfaceTintColor: AppColors2.color5,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .6,
                                          child: Text(
                                            schedule?.title ?? "",
                                            overflow: TextOverflow.fade,
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .6,
                                          child: Text(
                                            schedule?.subTitle ?? "",
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                fontSize: 14,
                                                color: Colors.black45),
                                          ),
                                        )
                                      ],
                                    ),
                                    CircleAvatar(
                                      radius: 25,
                                      backgroundImage: schedule?.picture == null
                                          ? null
                                          : NetworkImage(schedule!.picture!),
                                      child: schedule?.picture == null
                                          ? const Icon(Icons.person)
                                          : null,
                                    )
                                  ],
                                ),
                                Divider(),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.calendar_view_day,
                                          color: Colors.white,
                                          size: 12,
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          schedule!.date!,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 12),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.punch_clock_outlined,
                                          color: Colors.white,
                                          size: 12,
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          schedule.time!,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                          ),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.circle,
                                          size: 10,
                                          color: schedule.status == "Paid"
                                              ? Colors.green
                                              : Colors.red,
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(schedule.status!)
                                      ],
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: AppUtil.deviceWidth(context) * .37,
                                      height: 35,
                                      child: TextButton(
                                        style: ButtonStyle(
                                          backgroundColor:
                                              WidgetStateProperty.all(
                                            Colors.white,
                                          ),
                                        ),
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (_) {
                                              return AlertDialog(
                                                title: const Text(
                                                    "Cancel Appointment"),
                                                content: const Text(
                                                    "Are you sure you want to cancel the appointment?"),
                                                actions: [
                                                  SizedBox(
                                                    height: 40,
                                                    child: TextButton(
                                                      style: ButtonStyle(
                                                          backgroundColor:
                                                              WidgetStateProperty
                                                                  .all(Theme.of(
                                                                          context)
                                                                      .primaryColor)),
                                                      onPressed: () async {
                                                        context
                                                            .read<
                                                                ScheduleBloc>()
                                                            .add(CancelAppointmentEvent(
                                                                ref: schedule
                                                                    .key!));

                                                        Navigator.pop(context);
                                                      },
                                                      child: const Text(
                                                        "Yes",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Text(
                                                      "No",
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              );
                                            },
                                          );
                                        },
                                        child: const Text(
                                          "Cancel",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: AppUtil.deviceWidth(context) * .37,
                                      height: 35,
                                      child: ElevatedButton(
                                        style: ButtonStyle(
                                          backgroundColor:
                                              WidgetStateProperty.all(
                                                  Theme.of(context)
                                                      .primaryColor),
                                        ),
                                        onPressed: () {
                                          // goto appointment page
                                          if (services == null) {
                                            Navigator.pushNamed(
                                                context, AppRoute.services);
                                          } else {
                                            Service service =
                                                services!.firstWhere((si) {
                                              return si.key ==
                                                  schedule.specialtyKey;
                                            });

                                            Data appData = context
                                                .read<AppBloc>()
                                                .state
                                                .appData!;
                                            if (appData
                                                    .webViews!
                                                    .rescheduleAppointment!
                                                    .webview ==
                                                1) {
                                              Navigator.pushNamed(
                                                  context, AppRoute.webView,
                                                  arguments: {
                                                    'title': service.title,
                                                    'url':
                                                        '${appData.webViews!.rescheduleAppointment!.endpoint}&appointment_id=${service.key}',
                                                  });
                                              return;
                                            }

                                            Navigator.pushNamed(
                                                context, AppRoute.service,
                                                arguments: {
                                                  'service': service,
                                                  'rescheduling': schedule
                                                });
                                          }
                                        },
                                        child: const Text(
                                          "Reschedule",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14),
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: upcomingSchedules!.length,
                  ),
                );
    });
  }
}
