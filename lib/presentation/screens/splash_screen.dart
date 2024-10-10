import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hyella_telehealth/core/constants/app_colors2.dart';
import 'package:hyella_telehealth/core/constants/app_constants.dart';
import 'package:hyella_telehealth/core/global.dart';
import 'package:hyella_telehealth/core/utils/http_util.dart';
import 'package:hyella_telehealth/data/repository/apis/initialize_app_api.dart';
import 'package:hyella_telehealth/data/repository/entities/endpoint_entity.dart';
import 'package:hyella_telehealth/logic/bloc/endpoint_bloc.dart';
import 'package:hyella_telehealth/presentation/route/app_route.dart';
import 'package:hyella_telehealth/presentation/widgets/toast_info.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    if (context.mounted) {
      Future.delayed(
          const Duration(seconds: 3), () => getAppResources(context));
    }
  }

  void getAppResources(BuildContext context,
      {connectionWasLost = false}) async {
    try {
      /* if (connectionWasLost) {
        toastInfo(
          msg: "Connection restored",
          backgroundColor: Colors.green,
          length: Toast.LENGTH_LONG,
        );
        
        getAppResources(connectionWasLost: false);
      } */

      EndPointEntity? result = await InitializeAppApi().fetchAppResource();
      if (result.data != null && result.data?.endPoint1 != null) {
        setupResources(context, result.data!);
      } else {
        toastInfo(msg: "App encountered network error");
      }
    } catch (e) {
      bool hasOpenedApp = Global.storageService
          .getBool(AppConstants.STORAGE_DEVICE_FOR_THE_FIRST_TIME);
      EndPointEntityData? endPointEntityData =
          Global.storageService.getEndpoints();

      if (!hasOpenedApp && endPointEntityData == null) {
        toastInfo(
          msg: "Connection loss",
          backgroundColor: Colors.red[400]!,
          length: Toast.LENGTH_LONG,
        );

        Future.delayed(
            const Duration(seconds: 6), () => getAppResources(context));
        return;
      }

      setupResources(context, endPointEntityData!);
    }
  }

  void setupResources(BuildContext context, EndPointEntityData data) {
    HttpUtil().setBaseUrl = "${data.endPoint1}?cid=${data.client!.id}&";
    Global.storageService
        .setString(AppConstants.STORAGE_CLIENT_ID, data.client?.id ?? '');
    AppColors2.instance.registerInstance(data.client!);

    if (context.mounted) {
      context.read<EndpointBloc>().add(
            TriggerEndpoint(
              endPointEntity: EndPointEntity(
                data: data,
                type: 1,
              ),
            ),
          );
      Navigator.pushReplacementNamed(
        context,
        AppRoute.initialRoute,
        // (e) => true,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Image.asset('assets/images/splash.jpg'),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
