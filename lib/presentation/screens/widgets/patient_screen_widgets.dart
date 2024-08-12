import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hyella_telehealth/core/constants/app_colors.dart';
import 'package:hyella_telehealth/data/repository/entities/login_response_entity.dart';
import 'package:hyella_telehealth/logic/bloc/app_bloc.dart';
import 'package:hyella_telehealth/logic/bloc/web_view_bloc.dart';
import 'package:hyella_telehealth/presentation/screens/patient/p_home.dart';
import 'package:hyella_telehealth/presentation/screens/patient/p_profile.dart';
import 'package:hyella_telehealth/presentation/screens/web_viewer_screen.dart';

Widget buildScreen(BuildContext context, int index) {
  Data appData = context.read<AppBloc>().state.appData!;
  List<Widget> _screens = [
    const PHome(),
    Center(child: Text('Chat')),
    Center(child: Text('Schedule')),
    BlocProvider(
      create: (context) => WebViewBloc(),
      child: Builder(builder: (context) {
        return WebViewerScreen(title: "My Wallet", url: appData.url);
      }),
    ),
    const PProfile(),
  ];

  return _screens[index];
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
          colorFilter: const ColorFilter.mode(
            AppColors.primaryColor,
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
          colorFilter: const ColorFilter.mode(
            AppColors.primaryColor,
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
          colorFilter: const ColorFilter.mode(
            AppColors.primaryColor,
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
          theme: const SvgTheme(currentColor: AppColors.primaryColor),
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
          colorFilter: const ColorFilter.mode(
            AppColors.primaryColor,
            BlendMode.srcIn,
          ),
        ),
      ),
    ),
  ];
}
