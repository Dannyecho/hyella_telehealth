import 'package:bloc/bloc.dart';

part 'web_view_event.dart';
part 'web_view_state.dart';

class WebViewBloc extends Bloc<WebViewEvent, WebViewState> {
  WebViewBloc()
      : super(WebViewState(
            onPageFinished: false, onPageStarted: false, onProgress: false)) {
    on<WebViewInProgress>((event, emit) {
      emit(WebViewState(
        onProgress: true,
        onPageStarted: false,
        onPageFinished: false,
      ));
    });
    on<WebViewPageStarted>((event, emit) {
      emit(WebViewState(
        onProgress: false,
        onPageStarted: true,
        onPageFinished: false,
      ));
    });
    on<WebViewPageCompleted>((event, emit) {
      emit(WebViewState(
        onProgress: false,
        onPageStarted: false,
        onPageFinished: true,
      ));
    });
  }
}
