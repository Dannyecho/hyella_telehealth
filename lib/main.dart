import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hyella_telehealth/core/constants/app_colors.dart';
import 'package:hyella_telehealth/core/constants/app_colors2.dart';
import 'package:hyella_telehealth/core/global.dart';
import 'package:hyella_telehealth/logic/bloc/app_bloc.dart';
import 'package:hyella_telehealth/logic/bloc/endpoint_bloc.dart';
import 'package:hyella_telehealth/logic/bloc/form_builder_bloc.dart';
import 'package:hyella_telehealth/presentation/route/app_route.dart';

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
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => EndpointBloc(),
        ),
        BlocProvider(
          create: (context) => FormBuilderBloc(),
        ),
        BlocProvider(
          create: (context) => AppBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'HYELLA TeleHealth',
        builder: EasyLoading.init(),
        theme: ThemeData(
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
