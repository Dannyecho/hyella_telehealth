import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hyella_telehealth/core/constants/app_colors2.dart';
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
          onPageFinished: (String url) {
            context.read<WebViewBloc>().add(WebViewPageCompleted());
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
            if (widget.webViewScreenType == WebViewScreenType.appointment &&
                request.url.contains("status=completed")) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Appointment Booked Successfully!"),
                  backgroundColor: Colors.green,
                ),
              );
              Navigator.pushNamedAndRemoveUntil(
                  context, AppRoute.home, (predicate) => false,
                  arguments: 2);
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

  Future<bool> _onBackPressed() async {
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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title!,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => _onBackPressed(),
        ),
      ),
      body: BlocBuilder<WebViewBloc, WebViewState>(
        builder: (context, state) {
          if (state.onPageFinished == false) {
            return Center(
                child: CircularProgressIndicator(
              color: AppColors2.color1,
            ));
          }
          return WebViewWidget(controller: _controller);
        },
      ),
    );
  }
}
