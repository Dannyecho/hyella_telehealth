import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hyella_telehealth/core/constants/app_colors2.dart';
import 'package:hyella_telehealth/core/global.dart';
import 'package:hyella_telehealth/logic/bloc/app_bloc.dart';
import 'package:hyella_telehealth/logic/bloc/chat_contact_bloc.dart';
import 'package:hyella_telehealth/logic/bloc/emr_bloc.dart';
import 'package:hyella_telehealth/logic/bloc/endpoint_bloc.dart';
import 'package:hyella_telehealth/logic/bloc/form_builder_bloc.dart';
import 'package:hyella_telehealth/logic/bloc/network_connectivity_bloc.dart';
import 'package:hyella_telehealth/logic/bloc/schedule_bloc.dart';
import 'package:hyella_telehealth/presentation/route/app_route.dart';

// Global key to access the scaffold messenger
final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

void main() async {
  print("===============In Main===============");
  await Global.init();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NetworkConnectivityBloc(),
          lazy: false,
        ),
        BlocProvider(
          create: (context) => EndpointBloc(),
        ),
        BlocProvider(
          create: (context) => FormBuilderBloc(),
        ),
        BlocProvider(
          create: (context) => AppBloc(),
        ),
        BlocProvider(
          create: (context) => ScheduleBloc(),
          lazy: false,
        ),
        BlocProvider(
          create: (context) => ChatContactBloc(),
          lazy: false,
        ),
        BlocProvider(
          create: (context) => EmrBloc(),
          lazy: false,
        ),
      ],
      child: MaterialApp(
        title: 'HYELLA TeleHealth',
        builder: EasyLoading.init(),
        scaffoldMessengerKey: scaffoldMessengerKey,
        theme: ThemeData(
          textTheme: GoogleFonts.openSansTextTheme(),
          appBarTheme: AppBarTheme(
            backgroundColor: AppColors2.color1,
            foregroundColor: Colors.white,
            elevation: 0,
          ),
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.white,
            surface: Colors.white,
            primary: AppColors2.color1,
          ),
          useMaterial3: true,
        ),
        initialRoute: AppRoute.splash,
        onGenerateRoute: AppRoute.onGenerateRoute,
      ),
    );
  }

  @override
  void dispose() {
    // AppRoute.dispose();
    super.dispose();
  }
}
