import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hyella_telehealth/core/utils/app_util.dart';
import 'package:hyella_telehealth/data/repository/entities/login_response_entity.dart';
import 'package:hyella_telehealth/logic/bloc/app_screen_bloc.dart';
import 'package:hyella_telehealth/presentation/route/app_route.dart';

Row pHomeHeader(User? appUser) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "${AppUtil.getGreeting()},",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                width: 4,
              ),
              Text(
                "${appUser?.lastName}",
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Text(
            "EMR: ${appUser?.emrNumber}",
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
      Image.asset(
        'assets/images/light-logo.png',
        width: 100,
      ),
    ],
  );
}

class DashboardHeader extends StatelessWidget {
  final String balance;
  final String name;
  final BuildContext context;
  final String? logoUri;
  final bool isFirstTime;
  const DashboardHeader(
      {super.key,
      required this.balance,
      required this.context,
      required this.name,
      required this.logoUri,
      required this.isFirstTime});

  @override
  Widget build(BuildContext context) {
    String wave = isFirstTime ? "👋" : "";
    return Container(
      margin: const EdgeInsets.only(top: 30, bottom: 10),
      width: AppUtil.deviceWidth(context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .6,
                    child: Text(
                      "$name $wave",
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.satisfy(
                        fontSize: 22,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    balance,
                    style: const TextStyle(
                        fontSize: 13,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ],
          ),
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () {
                  /* Navigator.of(context).pushNamed(
                    AppRoute.editProfile,
                  ); */
                  context.read<AppScreenBloc>().add(
                        SwitchScreen(index: 3),
                      );
                },
                child: (logoUri == null)
                    ? CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.person,
                          color: Colors.grey[300],
                          size: 30,
                        ),
                      )
                    : Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                            boxShadow: const [
                              BoxShadow(
                                offset: Offset(0, 1),
                                color: Colors.white,
                                spreadRadius: 1,
                                blurRadius: 5,
                              )
                            ]),
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.white,
                          backgroundImage: NetworkImage(logoUri!),
                        ),
                      ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

Widget serviceSection(Home appServices, BuildContext context) {
  return Column(
    children: [
      Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.symmetric(
            horizontal: AppUtil.deviceWidth(context) * .05),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Services",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            TextButton(
                onPressed: () {
                  context.read<AppScreenBloc>().add(SwitchScreen(index: 4));
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
        padding: EdgeInsets.symmetric(
            horizontal: AppUtil.deviceWidth(context) * .05),
        child: CarouselSlider(
          items: appServices.data
              .where((element) =>
                  element.title != "List of All Services & Specialities")
              .map(
                (e) => GestureDetector(
                  onTap: () {
                    if (e.endpoint != null && e.endpoint!.isNotEmpty) {
                      Navigator.pushNamed(context, AppRoute.webView,
                          arguments: {
                            'title': 'Booking ${e.title}',
                            'url': e.endpoint!
                          });

                      return;
                    }
                    Navigator.of(context).pushNamed(
                      AppRoute.service,
                      arguments: {'service': e},
                    );
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Color(0xffe4e5e9),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    padding: const EdgeInsets.only(right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: 60,
                          width: 60,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(10)),
                          child: CachedNetworkImage(
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) =>
                                      CircularProgressIndicator(
                                          value: downloadProgress.progress),
                              imageUrl: e.picture!),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                          width: AppUtil.deviceWidth(context) * .7 - 120,
                          child: Text(
                            e.title!,
                            /* e.title!.length > 16
                                ? e.title!.substring(0, 15) + "..."
                                : e.title!, */
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
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
            autoPlayInterval: const Duration(seconds: 4),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            enlargeCenterPage: true,
            scrollDirection: Axis.horizontal,
          ),
        ),
      ),
    ],
  );
}
