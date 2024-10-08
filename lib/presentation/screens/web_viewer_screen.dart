import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hyella_telehealth/core/constants/app_colors2.dart';
import 'package:hyella_telehealth/logic/bloc/emr_bloc.dart';
import 'package:hyella_telehealth/logic/bloc/web_view_bloc.dart';
import 'package:hyella_telehealth/presentation/route/app_route.dart';
import 'package:webview_flutter/webview_flutter.dart';

enum WebViewScreenType {
  appointment,
  regular,
}

class WebViewerScreen extends StatefulWidget {
  final String? title;
  final String? url;
  final WebViewScreenType webViewScreenType;
  const WebViewerScreen({
    super.key,
    required this.title,
    required this.url,
    this.webViewScreenType = WebViewScreenType.regular,
  });

  @override
  State<WebViewerScreen> createState() => _WebViewerScreenState();
}

class _WebViewerScreenState extends State<WebViewerScreen> {
  late final _controller;
  @override
  void initState() {
    super.initState();
    final WebViewController controller = WebViewController();
    context.read<WebViewBloc>().add(WebViewSetTitle(title: widget.title));
    // #enddocregion platform_features

    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            context.read<WebViewBloc>().add(WebViewInProgress());
            debugPrint('WebView is loading (progress : $progress%)');
          },
          onPageStarted: (String url) {
            context.read<WebViewBloc>().add(WebViewPageStarted());
            debugPrint('Page started loading: $url');
          },
          onPageFinished: (String url) async {
            context.read<WebViewBloc>().add(WebViewPageCompleted());
            context
                .read<WebViewBloc>()
                .add(WebViewSetTitle(title: await controller.getTitle()));
            if (url.contains('&status=completed')) {
              context.read<WebViewBloc>().add(WebViewSetCanGoHome(value: true));
              print(
                  "============Completed Status: ${context.read<WebViewBloc>().state.canGoHome}");
            }
            debugPrint('Page finished loading: $url');
          },
          onWebResourceError: (WebResourceError error) {
            /* ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("An error occured on fetching resources"),
                backgroundColor: Colors.red,
              ),
            ); */
            debugPrint('''
              Page resource error:
                code: ${error.errorCode}
                description: ${error.description}
                errorType: ${error.errorType}
                isForMainFrame: ${error.isForMainFrame}
              ''');
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              debugPrint('blocking navigation to ${request.url}');
              return NavigationDecision.prevent;
            }
            /* if (widget.webViewScreenType == WebViewScreenType.appointment &&
                request.url.contains("&nwp_mobile_reload_chat=1")) { */
            if (request.url.contains("&nwp_mobile_reload_chat=1")) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Appointment Booked Successfully!"),
                  backgroundColor: Colors.green,
                ),
              );

              // Empty Cached EmrOptions
              context.read<EmrBloc>().add(EmptyAllEmrOptionsEvent());
              Navigator.pushNamedAndRemoveUntil(
                  context, AppRoute.home, (predicate) => false,
                  arguments: 0);
            }
            debugPrint('allowing navigation to ${request.url}');
            return NavigationDecision.navigate;
          },
          onHttpError: (HttpResponseError error) {
            /* ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Could not load page"),
                backgroundColor: Colors.red,
              ),
            ); */
            debugPrint('Error occurred on page: ${error.response?.statusCode}');
          },
          onUrlChange: (UrlChange change) {
            debugPrint('url change to ${change.url}');
          }, /* 
          onHttpAuthRequest: (HttpAuthRequest request) {
            openDialog(request);
          }, */
        ),
      )
      ..addJavaScriptChannel(
        'Toaster',
        onMessageReceived: (JavaScriptMessage message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        },
      )
      ..loadRequest(Uri.parse(widget.url!));

    _controller = controller;
  }

  Future<bool> _onBackPressed(BuildContext context) async {
    if (context.read<WebViewBloc>().state.canGoHome) {
      print("IN CAN GO HOME ------------");
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoute.initialRoute,
        (predicate) => false,
      );
    }
    if (await _controller.canGoBack()) {
      await _controller.goBack();
      return Future.value(false);
    } else {
      Navigator.pop(context);
      return Future.value(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WebViewBloc, WebViewState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              state.pageTitle,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => _onBackPressed(context),
            ),
          ),
          body: state.onPageFinished == false
              ? Center(
                  child: CircularProgressIndicator(
                  color: AppColors2.color1,
                ))
              : WebViewWidget(controller: _controller),
        );
      },
    );
  }
}
