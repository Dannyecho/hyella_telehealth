import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hyella_telehealth/core/constants/app_colors2.dart';
import 'package:hyella_telehealth/core/global.dart';
import 'package:hyella_telehealth/core/services/notification_service.dart';
import 'package:hyella_telehealth/data/repository/entities/login_response_entity.dart';
import 'package:hyella_telehealth/logic/bloc/app_bloc.dart';
import 'package:hyella_telehealth/logic/bloc/emr_bloc.dart';
import 'package:hyella_telehealth/logic/bloc/network_connectivity_bloc.dart';
import 'package:hyella_telehealth/presentation/route/app_route.dart';
import 'package:hyella_telehealth/presentation/screens/doctor_screen.dart';
import 'package:hyella_telehealth/presentation/screens/patient_screen2.dart';

class HomePage extends StatefulWidget {
  final int? currentScreen;
  const HomePage({super.key, this.currentScreen});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    initApp();
    refreshIn30minsEvent(context);
  }

  void refreshIn30minsEvent(BuildContext context) {
    // Function execute every 30 minutes
    Timer.periodic(const Duration(minutes: 30), (timer) {
      emptyEmrOptions(context);
    });
  }

  void emptyEmrOptions(BuildContext context) {
    context.read<EmrBloc>().add(EmptyAllEmrOptionsEvent());
  }

  void initApp() async {
    Data? appData = Global.storageService.getAppData();
    if (appData?.user == null) {
      Navigator.pushNamedAndRemoveUntil(context, AppRoute.signIn, (e) => false);
      return;
    }
    context.read<AppBloc>().add(SetAppDataEvent(appData: appData!));
    context.read<AppBloc>().add(SetUserEvent(user: appData.user!));
    NotificationService.instance.initForegroundMessaging();

    await Global.initAppDataEvents(context);
  }

  @override
  Widget build(BuildContext context) {
    // Global.storageService.remove(AppConstants.STORAGE_USER_TOKEN_KEY);
    return BlocConsumer<NetworkConnectivityBloc, NetworkConnectivityState>(
      listener: (context, state) {
        if (state.connectivity.contains(ConnectivityResult.none)) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red,
              content: Text(
                _getConnectivityMessage(ConnectivityResult.none),
              ),
              duration: const Duration(seconds: 2),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.green,
              content: Text(
                "Connection Restored",
              ),
              duration: Duration(seconds: 2),
            ),
          );
        }
      },
      builder: (context, state) {
        return BlocBuilder<AppBloc, AppBlocState>(builder: (context, state) {
          if (state.appData == null) {
            return Center(
              child: CircularProgressIndicator(
                color: AppColors2.color1,
              ),
            );
          }
          if (state.appData!.user!.isPatient == 0) {
            return const DoctorScreen();
          }
          return PatientScreen2(
            index: widget.currentScreen ?? 0,
          );
        });
      },
    );
  }

  String _getConnectivityMessage(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.none:
        return 'No internet connection';
      case ConnectivityResult.mobile:
        return 'Mobile data connected';
      case ConnectivityResult.wifi:
        return 'Wi-Fi connected';
      case ConnectivityResult.ethernet:
        return 'Ethernet connected';
      default:
        return 'Unknown connectivity';
    }
  }
}
