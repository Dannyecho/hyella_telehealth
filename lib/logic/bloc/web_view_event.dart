part of 'web_view_bloc.dart';

abstract class WebViewEvent {}

final class WebViewInProgress extends WebViewEvent {}

final class WebViewPageStarted extends WebViewEvent {}

final class WebViewPageCompleted extends WebViewEvent {}
