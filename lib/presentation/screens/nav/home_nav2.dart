import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hyella_telehealth/core/constants/app_colors2.dart';
import 'package:hyella_telehealth/core/global.dart';
import 'package:hyella_telehealth/data/repository/entities/endpoint_entity.dart';
import 'package:hyella_telehealth/data/repository/entities/login_response_entity.dart';
import 'package:hyella_telehealth/logic/bloc/app_bloc.dart';
import 'package:hyella_telehealth/logic/bloc/app_screen_bloc.dart';
import 'package:hyella_telehealth/logic/bloc/endpoint_bloc.dart';
import 'package:hyella_telehealth/logic/bloc/revenue_bloc.dart';
import 'package:hyella_telehealth/logic/bloc/schedule_bloc.dart';
import 'package:hyella_telehealth/presentation/route/app_route.dart';
import 'package:hyella_telehealth/presentation/screens/nav/widgets/home_widgets.dart';
import 'package:shimmer/shimmer.dart';

class HomeNav2 extends StatefulWidget {
  HomeNav2({Key? key}) : super(key: key);

  @override
  State<HomeNav2> createState() => _HomeNav2State();
}

class _HomeNav2State extends State<HomeNav2> {
  late Data? appData;
  late User appUser;
  late Home appServices;
  late Cards appCards;
  late final bool isDoctor;
  EndPointEntityData? endpointData = Global.storageService.getEndpoints();
  @override
  void initState() {
    super.initState();
    appData = Global.storageService.getAppData();

    if (appData?.user != null) {
      appUser = appData!.user!;
    }

    if (appData?.menu?.home != null) {
      appServices = appData!.menu!.home!;
    }

    if (appData?.menu?.cards != null) {
      appCards = appData!.menu!.cards!;
    }

    if (appUser.isStaff == 1) {
      isDoctor = true;
    } else {
      isDoctor = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final double _width = MediaQuery.of(context).size.width;
    final double _height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        color: const Color(0xffF8F8F8),
        child: RefreshIndicator(
          onRefresh: () async {
            context.read<AppBloc>().add(UpdateUserInfoEvent());
            context.read<EndpointBloc>().add(RefreshEndpointEvent());
            if (appUser.isStaff == 1) {
              context.read<RevenueBloc>().add(LoadRevenueEvent());
            }
            /*  appData = context.read<AppBloc>().state.appData;
            if (appData?.user != null) {
              appUser = appData!.user!;
            } else {
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoute.signIn,
                (a) => false,
              );
            } */
          },
          child: Column(
            children: [
              SizedBox(
                height: _height * .35,
                child: Stack(
                  children: [
                    Container(
                      height: _height * .25,
                      margin: const EdgeInsets.only(bottom: 25),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.elliptical(500, _height * .05),
                          bottomRight: Radius.elliptical(500, _height * .05),
                        ),
                      ),
                    ),
                    Positioned(
                      left: _width * .05,
                      top: _width * .05,
                      right: 20,
                      child: DashboardHeader(
                        balance: appUser.userNameSubtitle ?? "",
                        context: context,
                        name: endpointData?.client?.name ?? "",
                        logoUri: (appUser.dp == null || appUser.dp!.isEmpty)
                            ? null
                            : appUser.dp,
                        isFirstTime: appUser.isFirstUse == 1,
                      ),
                    ),
                    Positioned(
                      left: _width * .045,
                      right: _width * .045,
                      top: _height * .15,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              /* if (appData!.webViews?.bookAppointment?.webview ==
                                  1) {
                                Navigator.of(context)
                                    .pushNamed(AppRoute.webView, arguments: {
                                  'url': appData!
                                      .webViews!.bookAppointment!.endpoint!,
                                  'title': appData!.user!.bookAppointment!,
                                });
                                return;
                              } */

                              if (isDoctor) {
                                context
                                    .read<AppScreenBloc>()
                                    .add(SwitchScreen(index: 2));
                                return;
                              }
                              context
                                  .read<AppScreenBloc>()
                                  .add(SwitchScreen(index: 4));
                            },
                            child: Card(
                              shadowColor: Colors.black45,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              color: AppColors2.color3,
                              elevation: 15,
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                width: _width * .427,
                                height: _width * .35,
                                child: Stack(
                                  children: [
                                    Positioned(
                                      left: -10,
                                      top: -10,
                                      child: Container(
                                        height: _width * .2,
                                        width: _width * .2,
                                        decoration: BoxDecoration(
                                          color: AppColors2.color3,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(_width),
                                            topRight:
                                                Radius.circular(_width * .8),
                                            bottomLeft:
                                                Radius.circular(_width * .8),
                                            bottomRight:
                                                Radius.circular(_width * .8),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      // padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            height: 40,
                                            width: 40,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    const BorderRadius.all(
                                                  Radius.circular(5),
                                                ),
                                                color: AppColors2.color2),
                                            child: const Icon(
                                              Icons.calendar_today,
                                              color: Colors.white,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            appData!.user!.bookAppointment!,
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(
                                            height: 2,
                                          ),
                                          Text(
                                            appData!
                                                .user!.bookAppointmentSubtitle!,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black87),
                                          )
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                      top: 0,
                                      right: 0,
                                      child: Builder(
                                        builder: (context) {
                                          var upcomingSchedules = context
                                              .read<ScheduleBloc>()
                                              .loadedState
                                              .upComingSchedules;
                                          if (upcomingSchedules != null &&
                                              upcomingSchedules.isNotEmpty) {
                                            return CircleAvatar(
                                              backgroundColor:
                                                  AppColors2.color2,
                                              maxRadius: 15,
                                              minRadius: 10,
                                              child: Text(
                                                upcomingSchedules.length
                                                    .toString(),
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            );
                                          }

                                          return const SizedBox();
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: () {
                              if (isDoctor) {
                                Navigator.pushNamed(context, AppRoute.revenue);
                                return;
                              }
                              Navigator.of(context).pushNamed(
                                AppRoute.webView,
                                arguments: {
                                  'url': appData?.url,
                                  'title': appUser.accBalance,
                                },
                              );
                            },
                            child: Card(
                              shadowColor: Colors.black45,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              color: AppColors2.color5,
                              elevation: 15,
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                width: _width * .427,
                                height: _width * .35,
                                child: Stack(
                                  children: [
                                    Positioned(
                                      left: -10,
                                      top: -10,
                                      child: Container(
                                        height: _width * .2,
                                        width: _width * .2,
                                        decoration: BoxDecoration(
                                          color: AppColors2.color5,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(_width),
                                            topRight:
                                                Radius.circular(_width * .8),
                                            bottomLeft:
                                                Radius.circular(_width * .8),
                                            bottomRight:
                                                Radius.circular(_width * .8),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            height: 40,
                                            width: 40,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    const BorderRadius.all(
                                                  Radius.circular(5),
                                                ),
                                                color: AppColors2.color4),
                                            child: const Icon(
                                              Icons.wallet,
                                              color: Colors.white,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            appData!.user!.accBalance!,
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(
                                            height: 2,
                                          ),
                                          Text(
                                            appData!.user!.accBalanceSubtitle!,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black87),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              appUser.isStaff == 1
                  ? BlocBuilder<RevenueBloc, RevenueState>(
                      builder: (context, state) {
                        return state is RevenueStateLoading
                            ? Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[100]!,
                                child: Container(
                                  width: _width,
                                  margin: const EdgeInsets.all(20),
                                  padding: const EdgeInsets.all(20),
                                  height: 120,
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                              )
                            : state is RevenueStateLoaded
                                ? Container(
                                    height: _height * .18,
                                    margin: EdgeInsets.only(
                                      // bottom: 10,
                                      left: _width * .05,
                                      right: _width * .05,
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 15,
                                      vertical: 10,
                                    ),
                                    decoration: BoxDecoration(
                                        color: const Color(0xffe4e5e9),
                                        // color: AppColors2.color1,
                                        borderRadius: BorderRadius.circular(20),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(.2),
                                            offset: const Offset(0, 1),
                                            blurRadius: 2,
                                            spreadRadius: 1,
                                          )
                                        ]),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        state.data.title!,
                                                        style: const TextStyle(
                                                          fontSize: 16,
                                                          // color: Colors.white,
                                                        ),
                                                      ),
                                                      Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                          horizontal: 5,
                                                        ),
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              AppColors2.color1,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                        ),
                                                        child: Text(
                                                          state.data
                                                              .totalRevenue!,
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 22,
                                                            color: Colors.white,
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
                                                      color: AppColors2.color1,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                            IconButton(
                                                color: AppColors2.color1,
                                                onPressed: () {
                                                  context.read<RevenueBloc>().add(
                                                      ToggleViewBalanceEvent());
                                                },
                                                icon: state.openBalance
                                                    ? const FaIcon(
                                                        FontAwesomeIcons.eye)
                                                    : const FaIcon(
                                                        FontAwesomeIcons
                                                            .eyeSlash,
                                                      ))
                                          ],
                                        ),
                                        Builder(builder: (context) {
                                          return BlocBuilder<AppBloc,
                                              AppBlocState>(
                                            builder: (context, state) {
                                              return Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Divider(
                                                      endIndent: 100,
                                                      color: AppColors2.color1,
                                                    ),
                                                    Text(
                                                      state.appData?.appChart
                                                              ?.title ??
                                                          '',
                                                      softWrap: true,
                                                      style: const TextStyle(
                                                        fontSize: 16,
                                                        // color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    Text(
                                                      state.appData?.appChart
                                                              ?.subtitle ??
                                                          '',
                                                      softWrap: true,
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        color:
                                                            AppColors2.color1,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              );
                                            },
                                          );
                                        }),
                                      ],
                                    ),
                                  )
                                : const SizedBox();
                      },
                    )
                  : serviceSection(
                      appServices,
                      context,
                    ),
              const SizedBox(
                height: 30,
              ),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: appData!.menu!.cards!.data.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, AppRoute.emr, arguments: {
                          'title': appData?.menu?.cards?.data[index].title,
                          'key': appData?.menu?.cards?.data[index].key
                        });
                      },
                      child: Container(
                        height: 80,
                        margin: EdgeInsets.only(
                          bottom: 10,
                          left: _width * .05,
                          right: _width * .05,
                        ),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppColors2.color6,
                          borderRadius: BorderRadius.circular(
                            15,
                          ),
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              height: 60,
                              width: 60,
                              child: appData!
                                          .menu!.cards!.data[index].picture !=
                                      null
                                  ? CachedNetworkImage(
                                      progressIndicatorBuilder: (context, url,
                                              downloadProgress) =>
                                          CircularProgressIndicator(
                                              value: downloadProgress.progress),
                                      imageUrl: appData!
                                          .menu!.cards!.data[index].picture!,
                                    )
                                  : const SizedBox(),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: _width * .6,
                                  child: Text(
                                    appData!.menu!.cards!.data[index].title!,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  width: _width * .6,
                                  child: Text(
                                    appData!.menu!.cards!.data[index].subTitle!,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  /* Widget serviceSection(AuthProvider authProvider, BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          padding: EdgeInsets.symmetric(horizontal: deviceWidth(context) * .05),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Services",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              TextButton(
                  onPressed: () {
                    Provider.of<NavIndexProvider>(context, listen: false)
                        .setIndex(4);
                  },
                  child: Text(
                    "See all",
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 14,
                    ),
                  ))
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: deviceWidth(context) * .05),
          child: CarouselSlider(
            items: appData!.menu!.home!.data!
                .where((element) =>
                    element.title != "List of All Services & Specialities")
                .map(
                  (e) => GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => NewReservation(
                            specialtyId: e.key!,
                            specialties: appData!.menu!.home!.data!,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xffe4e5e9),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      padding: EdgeInsets.only(right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 60,
                            width: 60,
                            child: CachedNetworkImage(progressIndicatorBuilder:
                          (context, url, downloadProgress) =>
                              CircularProgressIndicator(
                                  value: downloadProgress.progress),imageUrl:e.picture!),
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            width: deviceWidth(context) * .7 - 120,
                            child: Text(
                              e.title!.length > 16
                                  ? e.title!.substring(0, 15) + "..."
                                  : e.title!,
                              maxLines: 1,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 15),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
                .toList(),
            options: CarouselOptions(
              height: 60,
              viewportFraction: 0.7,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 4),
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              scrollDirection: Axis.horizontal,
            ),
          ),
        ),
      ],
    );
  }
 */
}
