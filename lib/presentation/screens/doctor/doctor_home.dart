import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hyella_telehealth/core/constants/app_colors.dart';
import 'package:hyella_telehealth/core/constants/app_colors2.dart';
import 'package:hyella_telehealth/core/global.dart';
import 'package:hyella_telehealth/data/repository/entities/endpoint_entity.dart';
import 'package:hyella_telehealth/data/repository/entities/login_response_entity.dart';
import 'package:hyella_telehealth/logic/bloc/app_bloc.dart';
import 'package:hyella_telehealth/logic/bloc/endpoint_bloc.dart';
import 'package:hyella_telehealth/presentation/route/app_route.dart';

class DoctorHome extends StatefulWidget {
  const DoctorHome({super.key});

  @override
  State<DoctorHome> createState() => _DoctorHomeState();
}

class _DoctorHomeState extends State<DoctorHome> {
  late Data? appData;
  late User appUser;
  late Home appServices;
  late Cards appCards;
  EndPointEntityData? endpointData = Global.storageService.getEndpoints();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
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
  }

  @override
  Widget build(BuildContext context) {
    final double _width = MediaQuery.of(context).size.width;
    final double _height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        // color: const Color(0xffF8F8F8),
        color: AppColors2.color1,
        child: RefreshIndicator(
          onRefresh: () async {
            context.read<EndpointBloc>().add(RefreshEndpointEvent());
            context.read<AppBloc>().add(UpdateUserInfoEvent());
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
              Container(
                height: MediaQuery.of(context).size.height * .25,
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                  /* borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(
                      MediaQuery.of(context).size.width * .1,
                    ),
                    bottomRight: Radius.circular(
                      MediaQuery.of(context).size.width * .1,
                    ),
                  ), */
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: _width * .1,
                    horizontal: _width * .05,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // const Spacer(),
                      // Top Area
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 25,
                                backgroundColor: Colors.white,
                                child: appUser.dp != null &&
                                        appUser.dp!.isNotEmpty
                                    ? CachedNetworkImage(imageUrl: appUser.dp!)
                                    : const FaIcon(
                                        FontAwesomeIcons.userDoctor,
                                        size: 30,
                                        color: AppColors.lightText2,
                                      ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              SizedBox(
                                width: 100,
                                child: Text(
                                  appUser.userNameSubtitle ?? '',
                                  softWrap: true,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 200,
                            child: Text(
                              endpointData?.client?.name ?? "",
                              overflow: TextOverflow.clip,
                              softWrap: true,
                              textAlign: TextAlign.right,
                              style: GoogleFonts.satisfy(
                                fontSize: 22,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          homeButton(
                            context,
                            label: "New Appointments",
                            icon: const FaIcon(
                              FontAwesomeIcons.handHoldingMedical,
                              color: Colors.white,
                            ),
                            iconBackground: AppColors2.color2,
                            background: AppColors2.color3,
                          ),
                          homeButton(
                            context,
                            label: "Revenue History",
                            icon: const FaIcon(
                              FontAwesomeIcons.clockRotateLeft,
                              color: Colors.white,
                            ),
                            iconBackground: AppColors2.color4,
                            background: AppColors2.color5,
                          ),
                        ],
                      ),

                      // const Spacer(),
                    ],
                  ),
                ),
              ),
              // const Spacer(),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(_width * .05),
                  decoration: BoxDecoration(
                    color: const Color(0xffF8F8F8),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(_width * .1),
                      topRight: Radius.circular(_width * .1),
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: _height * .18,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Revenue Generated in 2022",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      '₦98,0000.00',
                                      style: TextStyle(
                                        fontSize: 22,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: '',
                                      ),
                                    ),
                                  ],
                                ),
                                IconButton(
                                    color: Colors.white,
                                    onPressed: () {},
                                    icon: const FaIcon(FontAwesomeIcons.eye))
                              ],
                            ),
                            const Divider(),
                            const Text(
                              'Forthcoming Appointments',
                              softWrap: true,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Text(
                              'Total: 152 in next 7 days',
                              softWrap: true,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.normal,
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Expanded(
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: appData!.menu!.cards!.data.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, AppRoute.emr,
                                    arguments: {
                                      'title': appData
                                          ?.menu?.cards?.data[index].title,
                                      'key':
                                          appData?.menu?.cards?.data[index].key
                                    });
                              },
                              child: Container(
                                height: 80,
                                margin: const EdgeInsets.only(
                                  bottom: 10,
                                  /* left: _width * .05,
                                  right: _width * .05, */
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
                                      child: appData!.menu!.cards!.data[index]
                                                  .picture !=
                                              null
                                          ? CachedNetworkImage(
                                              progressIndicatorBuilder:
                                                  (context, url,
                                                          downloadProgress) =>
                                                      CircularProgressIndicator(
                                                          value:
                                                              downloadProgress
                                                                  .progress),
                                              imageUrl: appData!.menu!.cards!
                                                  .data[index].picture!,
                                            )
                                          : const SizedBox(),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: _width * .6,
                                          child: Text(
                                            appData!.menu!.cards!.data[index]
                                                .title!,
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
                                            appData!.menu!.cards!.data[index]
                                                .subTitle!,
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
            ],
          ),
        ),
      ),
    );
  }

  Container homeButton(
    BuildContext context, {
    required String label,
    required FaIcon icon,
    Color? background,
    Color? iconBackground,
  }) {
    final _width = MediaQuery.of(context).size.width;
    return Container(
      width: _width * .43,
      // height: _width * .2,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: background,
        borderRadius: const BorderRadius.all(Radius.circular(14)),
      ),
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.center,
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(5),
                  ),
                  color: iconBackground,
                ),
                child: icon,
              ),
              SizedBox(
                width: _width * .28,
                child: Text(
                  label,
                  softWrap: true,
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.fade,
                  maxLines: 2,
                  style: const TextStyle(
                    // color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          /*  Positioned(
                                top: 0,
                                right: 0,
                                child: Container(
                                  height: 20,
                                  width: 20,
                                  decoration: BoxDecoration(
                                      color: AppColors2.color2,
                                      borderRadius:
                                          BorderRadius.circular(20)),
                                  child: const Text(
                                    "12",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              )
                             */
        ],
      ),
    );
  }
}
