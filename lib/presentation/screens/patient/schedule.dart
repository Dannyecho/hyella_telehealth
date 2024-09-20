import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hyella_telehealth/core/constants/app_colors2.dart';
import 'package:hyella_telehealth/core/utils/app_util.dart';
import 'package:hyella_telehealth/logic/bloc/app_screen_bloc.dart';
import 'package:hyella_telehealth/logic/bloc/schedule_bloc.dart';
import 'package:hyella_telehealth/presentation/screens/patient/widgets/cancelled_schedules.dart';
import 'package:hyella_telehealth/presentation/screens/patient/widgets/completed_schedules.dart';
import 'package:hyella_telehealth/presentation/screens/patient/widgets/shedule_shimmer.dart';
import 'package:hyella_telehealth/presentation/screens/patient/widgets/upcoming_schedule.dart';

class Schedule extends StatefulWidget {
  Schedule({Key? key}) : super(key: key);

  @override
  _ScheduleState createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  bool rescheduling = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    if (context.read<ScheduleBloc>().state is! ScheduleLoaded) {
      context.read<ScheduleBloc>().add(LoadUpComingScheduleEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Schedule',
            style: TextStyle(fontSize: 16),
          ),
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                context.read<AppScreenBloc>().add(SwitchScreen(index: 0));
              },
              icon: const Icon(Icons.arrow_back)),
        ),
        backgroundColor: const Color(0xffF8F8F8),
        body: SafeArea(
          child: Column(
            children: [
              /* const SizedBox(
                height: 5,
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: const Text(
                  "Schedule",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ), */
              /*  const SizedBox(
                height: 15,
              ), */
              // give the tab bar a height [can change height to preferred height]
              Container(
                height: 45,
                // width: AppUtil.deviceWidth(context) * .9,
                decoration: BoxDecoration(
                  color: AppColors2.color1,
                  // borderRadius: BorderRadius.circular(10),
                ),
                child: TabBar(
                  controller: _tabController,
                  // give the indicator a decoration (color and border radius)
                  indicator: BoxDecoration(
                      border: const Border(
                          bottom: BorderSide(
                        color: Colors.white,
                        width: 3,
                      )),
                      /* borderRadius: BorderRadius.circular(
                        10.0,
                      ), */
                      color: Theme.of(context).primaryColor),
                  labelColor: Colors.white,

                  unselectedLabelColor: Colors.black45,
                  tabs: const [
                    // first tab [you can add an icon using the icon property]
                    Tab(
                      text: 'Upcoming',
                    ),

                    // second tab [you can add an icon using the icon property]
                    Tab(
                      text: 'Completed',
                    ),
                    Tab(
                      text: 'Cancelled',
                    ),
                  ],
                ),
              ),
              // tab bar view here
              BlocBuilder<ScheduleBloc, ScheduleState>(
                  builder: (context, state) {
                return Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: AppUtil.deviceWidth(context) * .05),
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        state is ScheduleLoading
                            ? const ScheduleShimmer()
                            : UpcomingSchedule(),
                        state is ScheduleLoading
                            ? const ScheduleShimmer()
                            : const CompletedSchedule(),
                        state is ScheduleLoading
                            ? const ScheduleShimmer()
                            : CancelledSchedule(),
                      ],
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
