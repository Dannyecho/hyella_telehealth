import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hyella_telehealth/core/constants/app_colors2.dart';
import 'package:hyella_telehealth/core/global.dart';
import 'package:hyella_telehealth/core/services/notification_service.dart';
import 'package:hyella_telehealth/data/repository/entities/login_response_entity.dart';
import 'package:hyella_telehealth/logic/bloc/app_bloc.dart';
import 'package:hyella_telehealth/presentation/route/app_route.dart';
import 'package:hyella_telehealth/presentation/screens/doctor_screen.dart';
import 'package:hyella_telehealth/presentation/screens/patient_screen2.dart';

class HomePage extends StatefulWidget {
  int? currentScreen = 0;
  HomePage({super.key, this.currentScreen});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    initApp();
    _listenToConnectivity();
  }

  void initApp() async {
    Data? appData = Global.storageService.getAppData();
    if (appData == null) {
      Navigator.pushNamedAndRemoveUntil(context, AppRoute.signIn, (e) => false);
      return;
    }
    context.read<AppBloc>().add(SetAppDataEvent(appData: appData));
    context.read<AppBloc>().add(SetUserEvent(user: appData.user!));
    NotificationService.instance.initForegroundMessaging();

    await Global.initAppDataEvents(context);
  }

  Future<void> _listenToConnectivity() async {
    Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> result) {
      // Received changes in available connectivity types!
      // Display a Snackbar on connectivity change
      if (result.contains(ConnectivityResult.none)) {
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
    });
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

  @override
  Widget build(BuildContext context) {
    // Global.storageService.remove(AppConstants.STORAGE_USER_TOKEN_KEY);
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
  }
}
