import 'package:bloc/bloc.dart';

part 'web_view_event.dart';
part 'web_view_state.dart';

class WebViewBloc extends Bloc<WebViewEvent, WebViewState> {
  WebViewBloc()
      : super(
          WebViewState(
            canGoHome: false,
            pageTitle: '',
            onPageFinished: false,
            onPageStarted: false,
            onProgress: false,
          ),
        ) {
    on<WebViewSetCanGoHome>((event, emit) {
      emit(state.copyWith(canGoHome: event.value));
    });
    on<WebViewSetTitle>((event, emit) {
      if (event.title != null) {
        emit(state.copyWith(pageTitle: event.title));
      }
    });
    on<WebViewInProgress>((event, emit) {
      emit(state.copyWith(
        onProgress: true,
        onPageStarted: false,
        onPageFinished: false,
      ));
    });
    on<WebViewPageStarted>((event, emit) {
      emit(state.copyWith(
        onProgress: false,
        onPageStarted: true,
        onPageFinished: false,
      ));
    });
    on<WebViewPageCompleted>((event, emit) {
      emit(state.copyWith(
        onProgress: false,
        onPageStarted: false,
        onPageFinished: true,
      ));
    });
  }
}
