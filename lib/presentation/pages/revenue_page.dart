import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hyella_telehealth/core/constants/app_colors2.dart';
import 'package:hyella_telehealth/data/repository/entities/login_response_entity.dart';
import 'package:hyella_telehealth/logic/bloc/app_bloc.dart';
import 'package:hyella_telehealth/logic/bloc/revenue_bloc.dart';
import 'package:shimmer/shimmer.dart';

class RevenuePage extends StatefulWidget {
  const RevenuePage({super.key});

  @override
  State<RevenuePage> createState() => _RevenuePageState();
}

class _RevenuePageState extends State<RevenuePage> {
  late AppChart? appChart;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    appChart = context.read<AppBloc>().state.appData?.appChart;
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "My Revenue",
          style: TextStyle(fontSize: 16),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<RevenueBloc, RevenueState>(
        builder: (context, state) {
          return RefreshIndicator(
            onRefresh: () async {
              context.read<RevenueBloc>().add(LoadRevenueEvent());
            },
            child: state is RevenueStateLoading
                ? revenueShimmer()
                : state is RevenueStateLoaded
                    ? SafeArea(
                        child: Container(
                        color: AppColors2.color1,
                        child: Column(
                          children: [
                            Container(
                              // color: AppColors2.color1,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 15,
                              ),
                              child: Container(
                                height: _height * .18,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 15,
                                  vertical: 10,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(.2),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        state.openBalance
                                            ? Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    state.data.title!,
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      horizontal: 5,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color: AppColors2.color4,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                    ),
                                                    child: Text(
                                                      state.data.totalRevenue!,
                                                      style: const TextStyle(
                                                        fontSize: 22,
                                                        // color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily: '',
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            : Text(
                                                "****",
                                                style: TextStyle(
                                                  // letterSpacing: 10,
                                                  fontSize: 25,
                                                  color: AppColors2.color4,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                        IconButton(
                                            color: Colors.white,
                                            onPressed: () {
                                              context.read<RevenueBloc>().add(
                                                  ToggleViewBalanceEvent());
                                            },
                                            icon: state.openBalance
                                                ? const FaIcon(
                                                    FontAwesomeIcons.eye)
                                                : const FaIcon(
                                                    FontAwesomeIcons.eyeSlash,
                                                  ))
                                      ],
                                    ),
                                    Builder(builder: (context) {
                                      return appChart == null
                                          ? const SizedBox()
                                          : Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Divider(),
                                                Text(
                                                  appChart?.title ?? '',
                                                  softWrap: true,
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(
                                                  appChart?.subtitle ?? '',
                                                  softWrap: true,
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: AppColors2.color3,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                                )
                                              ],
                                            );
                                    }),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                                child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 20),
                              width: _width,
                              decoration: BoxDecoration(
                                color: const Color(0xffF8F8F8),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(_width * .1),
                                  topRight: Radius.circular(_width * .1),
                                ),
                              ),
                              child: Column(
                                children: [
                                  const Text(
                                    "Monthly Breakdown",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Container(
                                    width: 30,
                                    height: 5,
                                    decoration: BoxDecoration(
                                      color: AppColors2.color4,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  Expanded(
                                    child: ListView.separated(
                                      itemBuilder: (context, index) {
                                        var item = state.data.details[index];
                                        return ListTile(
                                          leading: CircleAvatar(
                                            radius: 20,
                                            backgroundColor: AppColors2.color4,
                                            child: const FaIcon(
                                              FontAwesomeIcons.moneyBillWave,
                                              color: Colors.white,
                                            ),
                                          ),
                                          title: Text(
                                            item.title!,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          subtitle: Text(item.amount!),
                                        );
                                      },
                                      separatorBuilder: (context, index) =>
                                          const Divider(
                                        indent: 70,
                                      ),
                                      itemCount: state.data.details.length,
                                    ),
                                  )
                                ],
                              ),
                            ))
                          ],
                        ),
                      ))
                    : const Center(
                        child: Text("Unknown state"),
                      ),
          );
        },
      ),
    );
  }

  Widget revenueShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView.separated(
        itemBuilder: (context, index) {
          if (index == 0) {
            return Container(
              height: 200,
              margin: const EdgeInsets.all(20),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(20),
              ),
            );
          }
          return ListTile(
            leading: CircleAvatar(
              radius: 20,
              backgroundColor: AppColors2.color2,
              child: const FaIcon(
                FontAwesomeIcons.moneyBillWave,
                color: Colors.white,
              ),
            ),
            title: const Text(
              "Month",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: const Text("Revenue"),
          );
        },
        separatorBuilder: (context, index) => const Divider(
          indent: 70,
        ),
        itemCount: 8,
      ),
    );
  }
}
