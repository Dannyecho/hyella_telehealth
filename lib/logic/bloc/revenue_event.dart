part of 'revenue_bloc.dart';

abstract class RevenueEvent {}

class LoadRevenueEvent extends RevenueEvent {}

class ToggleViewBalanceEvent extends RevenueEvent {}
