part of 'services_bloc.dart';

@immutable
sealed class ServicesEvent {}

class FetchServicesEvent extends ServicesEvent {
  final String query;
  FetchServicesEvent({required this.query});
}

class SetServicesEvent extends ServicesEvent {
  final List<Service> services;
  SetServicesEvent({required this.services});
}
