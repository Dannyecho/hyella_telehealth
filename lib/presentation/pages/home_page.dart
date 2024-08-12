import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hyella_telehealth/core/constants/app_colors.dart';
import 'package:hyella_telehealth/core/global.dart';
import 'package:hyella_telehealth/data/repository/entities/login_response_entity.dart';
import 'package:hyella_telehealth/logic/bloc/app_bloc.dart';
import 'package:hyella_telehealth/presentation/route/app_route.dart';
import 'package:hyella_telehealth/presentation/screens/doctor_screen.dart';
import 'package:hyella_telehealth/presentation/screens/patient_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    initApp();
  }

  void initApp() {
    Data? appData = Global.storageService.getAppData();
    if (appData == null) {
      Navigator.pushNamedAndRemoveUntil(context, AppRoute.signIn, (e) => false);
      return;
    }
    context.read<AppBloc>().add(SetAppDataEvent(appData: appData));
  }

  @override
  Widget build(BuildContext context) {
    // Global.storageService.remove(AppConstants.STORAGE_USER_TOKEN_KEY);
    return BlocBuilder<AppBloc, AppBlocState>(builder: (context, state) {
      if (state.appData == null) {
        return const Center(
          child: CircularProgressIndicator(
            color: AppColors.primaryColor,
          ),
        );
      }
      if (state.appData!.user!.isPatient == 0) {
        return const DoctorScreen();
      }
      return const PatientScreen();
    });
  }
}
