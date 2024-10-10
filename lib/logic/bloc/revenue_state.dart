// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'revenue_bloc.dart';

abstract class RevenueState {}

final class RevenueStateLoading extends RevenueState {}

final class RevenueStateLoaded extends RevenueState {
  final RevenueResponseData data;
  final bool openBalance;
  RevenueStateLoaded({
    required this.data,
    required this.openBalance,
  });

  RevenueStateLoaded copyWith({
    RevenueResponseData? data,
    bool? openBalance,
  }) {
    return RevenueStateLoaded(
      data: data ?? this.data,
      openBalance: openBalance ?? this.openBalance,
    );
  }
}
