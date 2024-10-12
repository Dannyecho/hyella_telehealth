import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hyella_telehealth/core/constants/app_colors.dart';
import 'package:hyella_telehealth/core/constants/app_colors2.dart';
import 'package:hyella_telehealth/core/utils/app_util.dart';
import 'package:hyella_telehealth/data/repository/entities/login_response_entity.dart';
import 'package:hyella_telehealth/logic/bloc/app_bloc.dart';
import 'package:hyella_telehealth/presentation/route/app_route.dart';
import 'package:hyella_telehealth/presentation/screens/nav/widgets/p_home_widgets.dart';

class PHome extends StatefulWidget {
  const PHome({super.key});

  @override
  State<PHome> createState() => _PHomeState();
}

class _PHomeState extends State<PHome> {
  late final Data? appData;
  late final User appUser;
  late final Home appServices;
  late final Cards appCards;
  @override
  void initState() {
    super.initState();
    appData = context.read<AppBloc>().state.appData;
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
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: 410,
            padding: const EdgeInsets.only(
              top: 60,
              left: 20,
              right: 20,
              bottom: 0,
            ),
            decoration: BoxDecoration(
              color: AppColors2.color1,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                pHomeHeader(appUser),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: Text(
                    appServices.title!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                SizedBox(
                  height: 190,
                  child: GridView.builder(
                    padding: const EdgeInsets.all(0),
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      var service = appServices.data[index + 1];
                      return InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, AppRoute.service,
                              arguments: {'service': service});
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.only(
                              bottom: 10, left: 10, right: 10, top: 5),
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(30, 255, 255, 255),
                              borderRadius: BorderRadius.circular(3)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CachedNetworkImage(
                                progressIndicatorBuilder:
                                    (context, url, downloadProgress) =>
                                        CircularProgressIndicator(
                                            value: downloadProgress.progress),
                                imageUrl: service.picture!,
                                width: 40,
                                height: 30,
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                AppUtil.capitalizeEachWord(service.title!),
                                maxLines: 2,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  overflow: TextOverflow.fade,
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                    itemCount: appServices.data.length - 1,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      mainAxisSpacing: 6,
                      crossAxisSpacing: 6,
                      childAspectRatio: 1,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, AppRoute.services,
                        arguments: appServices.data);
                  },
                  child: Container(
                    height: 32,
                    alignment: Alignment.bottomCenter,
                    margin: const EdgeInsets.only(top: 20),
                    child: const Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "See all",
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        Icon(
                          Icons.arrow_drop_down_sharp,
                          color: Colors.white,
                          size: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 300,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView.builder(
                itemBuilder: (context, index) {
                  var card = appCards.data[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.lightText,
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: Offset(0, 1),
                        )
                      ],
                    ),
                    child: ListTile(
                      leading: CachedNetworkImage(
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) =>
                                  CircularProgressIndicator(
                                      value: downloadProgress.progress),
                          imageUrl: card.picture!),
                      title: Text(
                        card.title!,
                        style: TextStyle(
                          color: AppColors2.color1,
                        ),
                      ),
                      subtitle: Text(
                        card.subTitle!,
                        style: const TextStyle(
                          color: AppColors.lightText2,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  );
                },
                itemCount: appCards.data.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
