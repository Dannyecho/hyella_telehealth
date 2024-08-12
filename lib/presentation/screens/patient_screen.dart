import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hyella_telehealth/core/constants/app_colors.dart';
import 'package:hyella_telehealth/logic/bloc/app_screen_bloc.dart';
import 'package:hyella_telehealth/presentation/screens/widgets/patient_screen_widgets.dart';

class PatientScreen extends StatefulWidget {
  const PatientScreen({super.key});

  @override
  State<PatientScreen> createState() => _PatientScreenState();
}

class _PatientScreenState extends State<PatientScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppScreenBloc, AppScreenState>(
      builder: (context, state) {
        return Scaffold(
            backgroundColor: Colors.white,
            body: buildScreen(context, state.index),
            bottomNavigationBar: Container(
              height: 60,
              decoration: const BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.lightText,
                      blurRadius: 1,
                      spreadRadius: 1,
                      offset: Offset(0, 0),
                    )
                  ]),
              child: BottomNavigationBar(
                currentIndex: state.index,
                onTap: (index) {
                  context.read<AppScreenBloc>().add(SwitchScreen(index: index));
                },
                elevation: 0,
                type: BottomNavigationBarType.fixed,
                showUnselectedLabels: true,
                showSelectedLabels: true,
                selectedItemColor: AppColors.primaryColor,
                unselectedItemColor: AppColors.lightText2,
                selectedFontSize: 12,
                items: buttonNavigatigationBarItem(),
              ),
            ));
      },
    );
  }
}
