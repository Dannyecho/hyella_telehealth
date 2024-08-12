import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hyella_telehealth/core/constants/app_constants.dart';
import 'package:hyella_telehealth/core/global.dart';
import 'package:hyella_telehealth/logic/bloc/app_bloc.dart';
import 'package:hyella_telehealth/logic/bloc/app_screen_bloc.dart';
import 'package:hyella_telehealth/logic/bloc/sign_in_bloc.dart';
import 'package:hyella_telehealth/logic/bloc/web_view_bloc.dart';
import 'package:hyella_telehealth/logic/bloc/welcome_bloc.dart';
import 'package:hyella_telehealth/presentation/pages/home_page.dart';
import 'package:hyella_telehealth/presentation/pages/sign_in_page.dart';
import 'package:hyella_telehealth/presentation/pages/welcome_page.dart';
import 'package:hyella_telehealth/presentation/screens/patient/p_edit_profile.dart';
import 'package:hyella_telehealth/presentation/screens/splash_screen.dart';
import 'package:hyella_telehealth/presentation/screens/web_viewer_screen.dart';

class AppRoute {
  static const String splash = '/';
  static const String home = 'home';
  static const String welcome = 'welcome';
  static const String signIn = 'signIn';
  static const String register = 'register';
  static const String profile = 'profile';
  static const String editProfile = 'editProfile';
  static const String settings = 'settings';
  static const String webView = 'webView';

  static Route? onGenerateRoute(RouteSettings rSettings) {
    switch (rSettings.name) {
      case home:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => AppBloc(),
              ),
              BlocProvider(
                create: (context) => AppScreenBloc(),
              ),
            ],
            child: const HomePage(),
          ),
        );
      case splash:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        );
      case welcome:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => WelcomeBloc(),
                  child: const WelcomePage(),
                ));
      case editProfile:
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: BlocProvider.of<AppBloc>(context),
            child: Builder(builder: (context) {
              return PEditProfile();
            }),
          ),
        );
      case webView:
        var arguements = rSettings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => WebViewBloc(),
                  child: WebViewerScreen(
                    title: arguements['title'],
                    url: arguements['url'],
                  ),
                ));
      case signIn:
      default:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => SignInBloc(),
            child: const SignInPage(),
          ),
        );
    }
  }

  static String get initialRoute {
    print('=============INIT ROUTE===============');
    bool hasOpenedApp = Global.storageService
        .getBool(AppConstants.STORAGE_DEVICE_FOR_THE_FIRST_TIME);
    if (!hasOpenedApp) {
      return welcome;
    }

    bool isLoggedIn = Global.storageService.getIsUserLoggedIn();
    if (isLoggedIn) {
      return home;
    }

    return signIn;
  }

  AppRoute._();
}
