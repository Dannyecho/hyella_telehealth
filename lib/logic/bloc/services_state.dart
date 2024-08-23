part of 'services_bloc.dart';

abstract class ServicesState {
  const ServicesState();
}

final class ServicesLoading extends ServicesState {}

final class ServicesLoadedState extends ServicesState {
  final List<Service> services;
  final String query;
  const ServicesLoadedState({required this.services, required this.query});
}
