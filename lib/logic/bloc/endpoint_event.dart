part of 'endpoint_bloc.dart';

abstract class EndpointEvent {}

class TriggerEndpoint extends EndpointEvent {
  final EndPointEntity endPointEntity;
  TriggerEndpoint({required this.endPointEntity});
}
