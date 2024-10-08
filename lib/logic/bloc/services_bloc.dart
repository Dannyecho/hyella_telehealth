import 'package:bloc/bloc.dart';
import 'package:hyella_telehealth/data/repository/entities/login_response_entity.dart';
import 'package:meta/meta.dart';

part 'services_event.dart';
part 'services_state.dart';

class ServicesBloc extends Bloc<ServicesEvent, ServicesState> {
  late List<Service> services;
  ServicesBloc() : super(ServicesLoading()) {
    on<SetServicesEvent>((event, emit) {
      services = event.services;
      emit(ServicesLoadedState(services: event.services, query: ''));
    });

    on<FetchServicesEvent>((event, emit) {
      emit(ServicesLoading());
      if (event.query.isEmpty) {
        emit(ServicesLoadedState(services: services, query: event.query));
        return;
      }

      // for (serv in currentStata.s
      List<Service> searchedServices = services.where((service) {
        return service.title?.toLowerCase().contains(event.query.toString()) ??
            false;
      }).toList();

      emit(ServicesLoadedState(services: searchedServices, query: event.query));
    });
  }

  getServices(query) {}
}
