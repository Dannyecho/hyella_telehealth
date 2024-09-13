// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'web_view_bloc.dart';

final class WebViewState {
  final String pageTitle;
  final bool onProgress;
  final bool onPageStarted;
  final bool onPageFinished;
  final bool canGoHome;

  WebViewState({
    required this.pageTitle,
    required this.onProgress,
    required this.onPageStarted,
    required this.onPageFinished,
    required this.canGoHome,
  });

  WebViewState copyWith({
    String? pageTitle,
    bool? onProgress,
    bool? onPageStarted,
    bool? onPageFinished,
    bool? canGoHome,
  }) {
    return WebViewState(
      pageTitle: pageTitle ?? this.pageTitle,
      onProgress: onProgress ?? this.onProgress,
      onPageStarted: onPageStarted ?? this.onPageStarted,
      onPageFinished: onPageFinished ?? this.onPageFinished,
      canGoHome: canGoHome ?? this.canGoHome,
    );
  }
}
