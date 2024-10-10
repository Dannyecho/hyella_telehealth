import 'package:bloc/bloc.dart';
import 'package:hyella_telehealth/core/constants/app_constants.dart';
import 'package:hyella_telehealth/core/global.dart';
import 'package:hyella_telehealth/data/repository/apis/revenue_api.dart';
import 'package:hyella_telehealth/data/repository/entities/app_settings_entity.dart';
import 'package:hyella_telehealth/data/repository/entities/revenue_response_entity.dart';
import 'package:hyella_telehealth/presentation/widgets/toast_info.dart';

part 'revenue_event.dart';
part 'revenue_state.dart';

class RevenueBloc extends Bloc<RevenueEvent, RevenueState> {
  RevenueBloc() : super(RevenueStateLoading()) {
    on<LoadRevenueEvent>((event, emit) async {
      emit(RevenueStateLoading());
      var response = await RevenueApi().fetchRevenue();
      if (response.type == 0) {
        toastInfo(msg: response.msg!);
        return;
      }
      bool openBalance = true;
      AppSettingsEntity? settings = Global.storageService.getAppSettings();
      if (settings != null && settings.revenue != null) {
        openBalance = settings.revenue!.openBalance;
      }
      emit(RevenueStateLoaded(data: response.data!, openBalance: openBalance));
    });

    on<ToggleViewBalanceEvent>(
      (event, emit) {
        if (state is RevenueStateLoaded) {
          RevenueStateLoaded newState = (state as RevenueStateLoaded).copyWith(
              openBalance: !(state as RevenueStateLoaded).openBalance);

          saveSettings(newState);
          emit(newState);
        }
      },
    );
  }

  void saveSettings(RevenueStateLoaded state) {
    AppSettingsEntity? settings = Global.storageService.getAppSettings();

    settings ??= AppSettingsEntity();
    settings = settings.copyWith(
        revenue: RevenueSettings(openBalance: state.openBalance));
    Global.storageService
        .setString(AppConstants.STORAGE_APP_SETTINGS, settings.toJson());
  }
}
