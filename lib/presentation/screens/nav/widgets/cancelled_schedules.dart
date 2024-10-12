import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hyella_telehealth/core/constants/app_colors2.dart';
import 'package:hyella_telehealth/data/repository/entities/schedule_entity.dart';
import 'package:hyella_telehealth/logic/bloc/schedule_bloc.dart';
import 'package:hyella_telehealth/presentation/screens/nav/widgets/shedule_shimmer.dart';

// ignore: must_be_immutable
class CancelledSchedule extends StatelessWidget {
  CancelledSchedule({super.key});
  bool hasError = false;
  late List<ScheduleEntityData> cancelledSchedules;
  @override
  Widget build(BuildContext context) {
    ScheduleLoaded loaded =
        context.read<ScheduleBloc>().state as ScheduleLoaded;
    if (loaded.hasError) {
      hasError = true;
    } else {
      cancelledSchedules =
          (context.read<ScheduleBloc>().state as ScheduleLoaded)
              .cancelledSchedules!;
    }

    return BlocBuilder<ScheduleBloc, ScheduleState>(
      builder: (context, state) {
        return RefreshIndicator(
          onRefresh: () async {
            context.read<ScheduleBloc>().add(LoadCancelledScheduleEvent());
          },
          child: (state is ScheduleLoading)
              ? const ScheduleShimmer()
              : (state as ScheduleLoaded).hasError == true
                  ? Center(
                      child: ElevatedButton(
                        onPressed: () {
                          context
                              .read<ScheduleBloc>()
                              .add(LoadCancelledScheduleEvent());
                        },
                        child: const Text("Refresh"),
                      ),
                    )
                  : state.cancelledSchedules!.isEmpty
                      ? Center(
                          child: Column(
                            children: [
                              Text(
                                "You do not have any cancelled appointment\nin your schedule",
                                textAlign: TextAlign.center,
                                style: TextStyle(color: AppColors2.color1),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  context
                                      .read<ScheduleBloc>()
                                      .add(LoadCancelledScheduleEvent());
                                },
                                child: const Text("Refresh"),
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          itemBuilder: (context, index) {
                            var schedule = state.cancelledSchedules![index];
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
                                color: (AppColors2.color5 as Color)
                                    .withOpacity(.4),
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
                                                  schedule.title!,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w700),
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
                                                  schedule.subTitle ?? "",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.black45,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          CircleAvatar(
                                            radius: 25,
                                            backgroundImage:
                                                NetworkImage(schedule.picture!),
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
                                                color: Colors.black,
                                                size: 12,
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                schedule.date!,
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 12),
                                              )
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.punch_clock_outlined,
                                                color: Colors.black,
                                                size: 12,
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                schedule.time!,
                                                style: const TextStyle(
                                                  color: Colors.black,
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
                          itemCount: state.cancelledSchedules!.length,
                        ),
        );
      },
    );
  }
}
