part of 'web_view_bloc.dart';

abstract class WebViewEvent {}

final class WebViewSetTitle extends WebViewEvent {
  final String? title;

  WebViewSetTitle({required this.title});
}

final class WebViewSetCanGoHome extends WebViewEvent {
  final bool value;

  WebViewSetCanGoHome({required this.value});
}

final class WebViewInProgress extends WebViewEvent {}

final class WebViewPageStarted extends WebViewEvent {}

final class WebViewPageCompleted extends WebViewEvent {}
