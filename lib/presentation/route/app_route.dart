import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hyella_telehealth/core/constants/app_constants.dart';
import 'package:hyella_telehealth/core/global.dart';
import 'package:hyella_telehealth/data/repository/entities/chat_entity.dart';
import 'package:hyella_telehealth/data/repository/entities/login_response_entity.dart';
import 'package:hyella_telehealth/logic/bloc/app_screen_bloc.dart';
import 'package:hyella_telehealth/logic/bloc/appointment_bloc.dart';
import 'package:hyella_telehealth/logic/bloc/appointment_step_bloc.dart';
import 'package:hyella_telehealth/logic/bloc/chat_bloc.dart';
import 'package:hyella_telehealth/logic/bloc/lab_result_bloc.dart';
import 'package:hyella_telehealth/logic/bloc/profile_edit_bloc.dart';
import 'package:hyella_telehealth/logic/bloc/services_bloc.dart';
import 'package:hyella_telehealth/logic/bloc/sign_in_bloc.dart';
import 'package:hyella_telehealth/logic/bloc/web_view_bloc.dart';
import 'package:hyella_telehealth/logic/bloc/welcome_bloc.dart';
import 'package:hyella_telehealth/presentation/pages/forget_password_page.dart';
import 'package:hyella_telehealth/presentation/pages/page404.dart';
import 'package:hyella_telehealth/presentation/pages/chat_page.dart';
import 'package:hyella_telehealth/presentation/pages/emr_page.dart';
import 'package:hyella_telehealth/presentation/pages/home_page.dart';
import 'package:hyella_telehealth/presentation/pages/lab_result_page.dart';
import 'package:hyella_telehealth/presentation/pages/register_page.dart';
import 'package:hyella_telehealth/presentation/pages/revenue_page.dart';
import 'package:hyella_telehealth/presentation/pages/schedule_appointment.dart';
import 'package:hyella_telehealth/presentation/pages/services_page.dart';
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
  static const String forgetPassword = 'forgetPassword';
  static const String register = 'register';
  static const String profile = 'profile';
  static const String editProfile = 'editProfile';
  static const String settings = 'settings';
  static const String webView = 'webView';
  static const String service = 'service';
  static const String services = 'services';
  static const String emr = 'emr';
  static const String labResult = 'labResult';
  static const String chat = 'chat';
  static const String page404 = 'page404';
  static const String revenue = 'revenue';

  static Route? onGenerateRoute(RouteSettings rSettings) {
    switch (rSettings.name) {
      case page404:
        return MaterialPageRoute(builder: (context) => const Page404());
      case revenue:
        return MaterialPageRoute(builder: (context) => const RevenuePage());
      case chat:
        var arguments = rSettings.arguments as ChatPageData;
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => ChatBloc(),
            child: ChatPage(
              data: arguments,
            ),
          ),
        );
      case emr:
        Map<String, dynamic> data = rSettings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (context) => EmrPage(data: data),
        );
      case labResult:
        String? arguments = rSettings.arguments as String;
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => LabResultBloc(),
            child: LabResultPage(
              title: arguments,
            ),
          ),
        );
      case home:
        var arguments = rSettings.arguments is int ? rSettings.arguments : 0;
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => AppScreenBloc(),
              ),
              BlocProvider(
                create: (context) => ServicesBloc(),
              ),
            ],
            child: HomePage(
              currentScreen: arguments as int,
            ),
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
          builder: (context) => BlocProvider(
            create: (context) => ProfileEditBloc(),
            child: const PEditProfile(),
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
      case services:
        var arguements = rSettings.arguments as List<Service>;
        return MaterialPageRoute(
          builder: (context) => ServicesPage(services: arguements),
        );
      case service:
        var arguements = rSettings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
            builder: (context) => MultiBlocProvider(
                  providers: [
                    BlocProvider(
                      create: (context) => AppointmentBloc(),
                    ),
                    BlocProvider(
                      create: (context) => AppointmentStepBloc(),
                    ),
                  ],
                  child: ScheduleAppointment(
                    service: arguements['service'],
                    rescheduling: arguements.containsKey('rescheduling')
                        ? arguements['rescheduling']
                        : null,
                  ),
                ));
      case register:
        return MaterialPageRoute(builder: (context) => const RegisterPage());
      case forgetPassword:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => SignInBloc(),
                  child: const ForgetPasswordPage(),
                ));
      case signIn:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => SignInBloc(),
            child: const SignInPage(),
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => const Page404(),
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

    User? appUser = Global.storageService.getAppUser();
    if (appUser != null) {
      return home;
    }

    return signIn;
  }

  AppRoute._();
}
