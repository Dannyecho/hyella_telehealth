import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hyella_telehealth/core/services/notification_service.dart';
import 'package:hyella_telehealth/core/services/storage_service.dart';
import 'package:hyella_telehealth/data/repository/entities/login_response_entity.dart';
import 'package:hyella_telehealth/firebase_options.dart';
import 'package:hyella_telehealth/logic/bloc/chat_contact_bloc.dart';
import 'package:hyella_telehealth/logic/bloc/revenue_bloc.dart';
import 'package:hyella_telehealth/logic/bloc/schedule_bloc.dart';

final class Global {
  const Global._();
  static late final StorageService storageService;
  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    storageService = await StorageService().init();
    NotificationService.instance.init();
  }

  static Future<void> initAppDataEvents(BuildContext context) async {
    User? appUser = storageService.getAppUser();
    // Load contact list;
    context.read<ChatContactBloc>().add(LoadContactListEvent());

    // Load schdules;
    context.read<ScheduleBloc>().add(LoadUpComingScheduleEvent());
    context.read<ScheduleBloc>().add(LoadCompletedScheduleEvent());
    context.read<ScheduleBloc>().add(LoadCancelledScheduleEvent());

    if (appUser != null && appUser.isStaff == 1) {
      // Load revenue
      context.read<RevenueBloc>().add(LoadRevenueEvent());
    }
  }
}
