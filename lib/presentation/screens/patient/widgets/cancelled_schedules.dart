import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hyella_telehealth/data/repository/entities/schedule_entity.dart';
import 'package:hyella_telehealth/logic/bloc/schedule_bloc.dart';

// ignore: must_be_immutable
class CancelledSchedule extends StatelessWidget {
  CancelledSchedule({super.key});
  late List<ScheduleEntityData> cancelledSchedules;
  @override
  Widget build(BuildContext context) {
    cancelledSchedules = (context.read<ScheduleBloc>().state as ScheduleLoaded)
        .cancelledSchedules!;

    return BlocBuilder<ScheduleBloc, ScheduleState>(
      builder: (context, state) {
        return cancelledSchedules.isEmpty
            ? const Center(
                child: Text(
                  "You do not have any cancelled appointment\nin your schedule",
                  textAlign: TextAlign.center,
                ),
              )
            : RefreshIndicator(
                onRefresh: () async {
                  context
                      .read<ScheduleBloc>()
                      .add(LoadCancelledScheduleEvent());
                },
                child: ListView.builder(
                  itemBuilder: (context, index) {
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
                                      Text(
                                        cancelledSchedules[index].title!,
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        cancelledSchedules[index].subTitle ??
                                            "",
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.black45,
                                        ),
                                      )
                                    ],
                                  ),
                                  CircleAvatar(
                                    radius: 25,
                                    backgroundImage: NetworkImage(
                                        cancelledSchedules[index].picture!),
                                  )
                                ],
                              ),
                              const Divider(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.calendar_view_day,
                                        color: Color(0xffA8AFBD),
                                        size: 12,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        cancelledSchedules[index].date!,
                                        style: const TextStyle(
                                            color: Color(0xff9A9A9B),
                                            fontSize: 12),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.punch_clock_outlined,
                                        color: Color(0xffA8AFBD),
                                        size: 12,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        cancelledSchedules[index].time!,
                                        style: const TextStyle(
                                          color: Color(0xff9A9A9B),
                                          fontSize: 12,
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: cancelledSchedules.length,
                ),
              );
      },
    );
  }
}
