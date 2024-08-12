import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hyella_telehealth/core/constants/app_colors.dart';
import 'package:hyella_telehealth/core/constants/app_constants.dart';
import 'package:hyella_telehealth/core/global.dart';
import 'package:hyella_telehealth/data/repository/entities/login_response_entity.dart';
import 'package:hyella_telehealth/logic/bloc/app_bloc.dart';
import 'package:hyella_telehealth/presentation/route/app_route.dart';

class PProfile extends StatefulWidget {
  const PProfile({super.key});

  @override
  State<PProfile> createState() => _PProfileState();
}

class _PProfileState extends State<PProfile> {
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
          "Profile",
          style: TextStyle(fontSize: 16),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.only(
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
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage("assets/images/1.jpg"),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: SvgPicture.asset(
                              'assets/svg/pencil.svg',
                              width: 10,
                              height: 10,
                              colorFilter: const ColorFilter.mode(
                                  AppColors.primaryColor, BlendMode.srcIn),
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
                  color: AppColors.lightText,
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
                      leading: const Icon(
                        Icons.logout,
                        size: 28,
                        color: AppColors.primaryColor,
                      ),
                      title: const Text(
                        'Logout',
                        style: TextStyle(
                          color: AppColors.primaryColor,
                        ),
                      ),
                      trailing: Container(
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
                      ),
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
                    leading: Image.network(
                      moreDataItem.icon!,
                      width: 30,
                      height: 30,
                    ),
                    title: Text(
                      moreDataItem.title!,
                      style: const TextStyle(
                        color: AppColors.primaryColor,
                      ),
                    ),
                    trailing: Container(
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
                    ),
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
