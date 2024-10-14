import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hyella_telehealth/core/constants/app_colors2.dart';
import 'package:hyella_telehealth/core/constants/app_constants.dart';
import 'package:hyella_telehealth/core/global.dart';
import 'package:hyella_telehealth/data/repository/entities/login_response_entity.dart';
import 'package:hyella_telehealth/logic/bloc/app_bloc.dart';
import 'package:hyella_telehealth/logic/bloc/app_screen_bloc.dart';
import 'package:hyella_telehealth/presentation/route/app_route.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late User userDetails;
  late More moreData;
  @override
  void initState() {
    super.initState();
    userDetails = context.read<AppBloc>().state.appData!.user!;
    moreData = context.read<AppBloc>().state.appData!.menu!.more!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "More",
          style: TextStyle(fontSize: 16),
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              context.read<AppScreenBloc>().add(SwitchScreen(index: 0));
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors2.color1,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
              ),
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, AppRoute.editProfile);
                    },
                    child: Stack(
                      children: [
                        Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 3),
                              boxShadow: const [
                                BoxShadow(
                                  offset: Offset(0, 1),
                                  color: Colors.white,
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                )
                              ]
                              /* image: DecorationImage(
                              image: AssetImage("assets/images/1.jpg"),
                            ), */
                              ),
                          child:
                              userDetails.dp == null || userDetails.dp!.isEmpty
                                  ? CircleAvatar(
                                      radius: 20,
                                      backgroundColor: Colors.white,
                                      child: Icon(
                                        Icons.person,
                                        color: Colors.grey[300],
                                        size: 90,
                                      ),
                                    )
                                  : BlocBuilder<AppBloc, AppBlocState>(
                                      builder: (context, state) {
                                        return CircleAvatar(
                                          radius: 20,
                                          backgroundImage:
                                              CachedNetworkImageProvider(
                                            userDetails.dp!,
                                          ),
                                        );
                                      },
                                    ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            height: 35,
                            width: 35,
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(0, 1),
                                  color: Colors.white,
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                )
                              ],
                            ),
                            child: FaIcon(
                              FontAwesomeIcons.penToSquare,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    userDetails.fullName!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 500,
              child: ListView.separated(
                itemCount: moreData.data.length + 1,
                separatorBuilder: (context, index) => const Divider(
                    // color: AppColors2.color3,
                    ),
                itemBuilder: (context, index) {
                  if (index == moreData.data.length) {
                    return ListTile(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text("Confirm Logout"),
                                content: const Text(
                                    "Are you sure you want to log out?"),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text("Cancel"),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Global.storageService.remove(AppConstants
                                          .STORAGE_USER_PROFILE_KEY);
                                      Global.storageService.remove(
                                          AppConstants.STORAGE_USER_TOKEN_KEY);
                                      Global.storageService.remove(
                                          AppConstants.STORAGE_APP_DATA);
                                      Global.storageService.remove(
                                          AppConstants.STORAGE_USER_IS_PATIENT);

                                      Navigator.of(context)
                                          .pushNamedAndRemoveUntil(
                                        AppRoute.signIn,
                                        (x) => false,
                                      );
                                    },
                                    child: const Text("Confirm"),
                                  ),
                                ],
                              );
                            });
                      },
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 0,
                        horizontal: 20,
                      ),
                      leading: Icon(
                        Icons.logout,
                        size: 28,
                        color: AppColors2.color1,
                      ),
                      title: Text(
                        'Logout',
                        style: TextStyle(
                          color: AppColors2.color1,
                        ),
                      ),
                      /* trailing: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: AppColors2.color1,
                          shape: BoxShape.circle,
                        ),
                        child: SvgPicture.asset(
                          'assets/svg/angle-right.svg',
                          width: 12,
                          height: 12,
                        ),
                      ), */
                    );
                  }
                  var moreDataItem = moreData.data[index];
                  return ListTile(
                    onTap: () {
                      Navigator.pushNamed(context, AppRoute.webView,
                          arguments: {
                            'title': moreDataItem.title!,
                            'url': moreDataItem.menuKey!
                          });
                    },
                    style: ListTileStyle.drawer,
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 0,
                      horizontal: 20,
                    ),
                    leading: CachedNetworkImage(
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) =>
                              CircularProgressIndicator(
                                  value: downloadProgress.progress),
                      imageUrl: moreDataItem.icon!,
                      width: 30,
                      height: 30,
                    ),
                    title: Text(
                      moreDataItem.title!,
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    /* trailing: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        color: AppColors.lightText,
                        shape: BoxShape.circle,
                      ),
                      child: SvgPicture.asset(
                        'assets/svg/angle-right.svg',
                        width: 12,
                        height: 12,
                      ),
                    ), */
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
