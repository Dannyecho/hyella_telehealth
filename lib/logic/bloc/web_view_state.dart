part of 'web_view_bloc.dart';

final class WebViewState {
  final bool onProgress;
  final bool onPageStarted;
  final bool onPageFinished;

  WebViewState({
    required this.onProgress,
    required this.onPageStarted,
    required this.onPageFinished,
  });
}
