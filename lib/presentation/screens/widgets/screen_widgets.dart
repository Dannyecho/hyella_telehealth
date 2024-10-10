import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hyella_telehealth/core/constants/app_colors.dart';
import 'package:hyella_telehealth/core/constants/app_colors2.dart';
import 'package:hyella_telehealth/data/repository/entities/login_response_entity.dart';
import 'package:hyella_telehealth/logic/bloc/app_bloc.dart';
import 'package:hyella_telehealth/logic/bloc/web_view_bloc.dart';
import 'package:hyella_telehealth/presentation/pages/chat_contact_page.dart';
import 'package:hyella_telehealth/presentation/pages/services_page.dart';
import 'package:hyella_telehealth/presentation/screens/doctor/doctor_home.dart';
import 'package:hyella_telehealth/presentation/screens/patient/p_home.dart';
import 'package:hyella_telehealth/presentation/screens/patient/p_home2.dart';
import 'package:hyella_telehealth/presentation/screens/patient/p_profile.dart';
import 'package:hyella_telehealth/presentation/screens/patient/schedule.dart';
import 'package:hyella_telehealth/presentation/screens/web_viewer_screen.dart';

Widget buildScreen(BuildContext context, int index) {
  Data appData = context.read<AppBloc>().state.appData!;
  List<Widget> screens = [
    const PHome(),
    const Center(child: Text('Chat')),
    const Center(child: Text('Schedule')),
    BlocProvider(
      create: (context) => WebViewBloc(),
      child: Builder(
        builder: (context) {
          return WebViewerScreen(title: "My Wallet", url: appData.url);
        },
      ),
    ),
    const PProfile(),
  ];

  return screens[index];
}

Widget buildScreen2(BuildContext context, int index) {
  Data appData = context.read<AppBloc>().state.appData!;
  User user = appData.user!;
  Home appServices = appData.menu!.home!;
  List<Service> services =
      appServices.data.where((el) => el.key != 'all_services').toList();

  List<Widget> screens = [
    user.isStaff == 1 ? const DoctorHome() : PHome2(),
    const ChatContactPage(),
    Schedule(),
    const PProfile(),
    ServicesPage(
      services: services,
    ),
  ];

  return screens[index];
}

List<BottomNavigationBarItem> buttonNavigatigationBarItem() {
  return [
    BottomNavigationBarItem(
      label: 'Home',
      icon: SizedBox(
        height: 15,
        width: 15,
        child: SvgPicture.asset(
          'assets/svg/home.svg',
          colorFilter: const ColorFilter.mode(
            AppColors.lightText2,
            BlendMode.srcIn,
          ),
        ),
      ),
      activeIcon: SizedBox(
        height: 15,
        width: 15,
        child: SvgPicture.asset(
          'assets/svg/home.svg',
          colorFilter: ColorFilter.mode(
            AppColors2.color1,
            BlendMode.srcIn,
          ),
        ),
      ),
    ),
    BottomNavigationBarItem(
      label: 'Chat',
      icon: SizedBox(
        height: 15,
        width: 15,
        child: SvgPicture.asset(
          'assets/svg/comment.svg',
          colorFilter: const ColorFilter.mode(
            AppColors.lightText2,
            BlendMode.srcIn,
          ),
        ),
      ),
      activeIcon: SizedBox(
        height: 15,
        width: 15,
        child: SvgPicture.asset(
          'assets/svg/comment.svg',
          colorFilter: ColorFilter.mode(
            AppColors2.color1,
            BlendMode.srcIn,
          ),
        ),
      ),
    ),
    BottomNavigationBarItem(
      label: 'Schedule',
      icon: SizedBox(
        height: 15,
        width: 15,
        child: SvgPicture.asset(
          'assets/svg/calendar-clock.svg',
          colorFilter: const ColorFilter.mode(
            AppColors.lightText2,
            BlendMode.srcIn,
          ),
        ),
      ),
      activeIcon: SizedBox(
        height: 15,
        width: 15,
        child: SvgPicture.asset(
          'assets/svg/calendar-clock.svg',
          colorFilter: ColorFilter.mode(
            AppColors2.color1,
            BlendMode.srcIn,
          ),
        ),
      ),
    ),
    BottomNavigationBarItem(
      label: 'Wallet',
      icon: SizedBox(
        height: 15,
        width: 15,
        child: SvgPicture.asset(
          'assets/svg/wallet.svg',
          colorFilter: const ColorFilter.mode(
            AppColors.lightText2,
            BlendMode.srcIn,
          ),
        ),
      ),
      activeIcon: SizedBox(
        height: 15,
        width: 15,
        child: SvgPicture.asset(
          'assets/svg/wallet.svg',
          theme: SvgTheme(currentColor: AppColors2.color1),
        ),
      ),
    ),
    BottomNavigationBarItem(
      label: 'Profile',
      icon: SizedBox(
        height: 15,
        width: 15,
        child: SvgPicture.asset(
          'assets/svg/user.svg',
          colorFilter:
              const ColorFilter.mode(AppColors.lightText2, BlendMode.srcIn),
        ),
      ),
      activeIcon: SizedBox(
        height: 15,
        width: 15,
        child: SvgPicture.asset(
          'assets/svg/user.svg',
          colorFilter: ColorFilter.mode(
            AppColors2.color1,
            BlendMode.srcIn,
          ),
        ),
      ),
    ),
  ];
}

List<BottomNavigationBarItem> buttonNavigatigationBarItem2() {
  return [
    BottomNavigationBarItem(
      label: 'Home',
      icon: SizedBox(
        height: 15,
        width: 15,
        child: SvgPicture.asset(
          'assets/svg/home.svg',
          colorFilter: const ColorFilter.mode(
            AppColors.lightText2,
            BlendMode.srcIn,
          ),
        ),
      ),
      activeIcon: SizedBox(
        height: 15,
        width: 15,
        child: SvgPicture.asset(
          'assets/svg/home.svg',
          colorFilter: ColorFilter.mode(
            AppColors2.color1,
            BlendMode.srcIn,
          ),
        ),
      ),
    ),
    BottomNavigationBarItem(
      label: 'Chat',
      icon: SizedBox(
        height: 15,
        width: 15,
        child: SvgPicture.asset(
          'assets/svg/comment.svg',
          colorFilter: const ColorFilter.mode(
            AppColors.lightText2,
            BlendMode.srcIn,
          ),
        ),
      ),
      activeIcon: SizedBox(
        height: 15,
        width: 15,
        child: SvgPicture.asset(
          'assets/svg/comment.svg',
          colorFilter: ColorFilter.mode(
            AppColors2.color1,
            BlendMode.srcIn,
          ),
        ),
      ),
    ),
    BottomNavigationBarItem(
      label: 'Schedule',
      icon: SizedBox(
        height: 15,
        width: 15,
        child: SvgPicture.asset(
          'assets/svg/calendar-clock.svg',
          colorFilter: const ColorFilter.mode(
            AppColors.lightText2,
            BlendMode.srcIn,
          ),
        ),
      ),
      activeIcon: SizedBox(
        height: 15,
        width: 15,
        child: SvgPicture.asset(
          'assets/svg/calendar-clock.svg',
          colorFilter: ColorFilter.mode(
            AppColors2.color1,
            BlendMode.srcIn,
          ),
        ),
      ),
    ),
    BottomNavigationBarItem(
      label: 'Wallet',
      icon: SizedBox(
        height: 15,
        width: 15,
        child: SvgPicture.asset(
          'assets/svg/wallet.svg',
          colorFilter: const ColorFilter.mode(
            AppColors.lightText2,
            BlendMode.srcIn,
          ),
        ),
      ),
      activeIcon: SizedBox(
        height: 15,
        width: 15,
        child: SvgPicture.asset(
          'assets/svg/wallet.svg',
          theme: SvgTheme(currentColor: AppColors2.color1),
        ),
      ),
    ),
    BottomNavigationBarItem(
      label: 'Profile',
      icon: SizedBox(
        height: 15,
        width: 15,
        child: SvgPicture.asset(
          'assets/svg/user.svg',
          colorFilter:
              const ColorFilter.mode(AppColors.lightText2, BlendMode.srcIn),
        ),
      ),
      activeIcon: SizedBox(
        height: 15,
        width: 15,
        child: SvgPicture.asset(
          'assets/svg/user.svg',
          colorFilter: ColorFilter.mode(
            AppColors2.color1,
            BlendMode.srcIn,
          ),
        ),
      ),
    ),
  ];
}
