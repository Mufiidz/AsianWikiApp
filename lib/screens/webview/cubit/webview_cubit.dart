import 'package:bloc/bloc.dart';
import 'package:dart_mappable/dart_mappable.dart';
import 'package:injectable/injectable.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../data/base_state.dart';
import '../../../utils/logger.dart';

part 'webview_state.dart';
part 'webview_cubit.mapper.dart';

@injectable
class WebviewCubit extends Cubit<WebviewState> {
  WebViewController? _webViewController;
  String? currentUrl;
  bool isError = false;
  WebviewCubit() : super(WebviewState());

  void initial(WebViewController controller, String url) async {
    _webViewController = controller;
    currentUrl = url;
    if (_webViewController == null) return;
    await _webViewController?.setJavaScriptMode(JavaScriptMode.unrestricted);
    await _webViewController?.setNavigationDelegate(
      NavigationDelegate(
        onPageStarted: (String url) {
          currentUrl = url;
          isError = false;
          emit(state.copyWith(progress: 0, statusState: StatusState.loading));
        },
        onProgress: (int progress) {
          emit(state.copyWith(progress: (progress / 100)));
        },
        onPageFinished: (String url) {
          currentUrl = url;
          emit(
            state.copyWith(
              statusState: isError ? StatusState.failure : StatusState.idle,
            ),
          );
        },
        onHttpError: (HttpResponseError error) => logger.e('Http Error $error'),
        onWebResourceError: (WebResourceError error) {
          isError = true;
          emit(
            state.copyWith(
              statusState: StatusState.failure,
              message: error.description,
            ),
          );
        },
      ),
    );
    final Uri uri = Uri.parse(url);
    await _webViewController?.loadRequest(uri);
  }

  void loadUrl() async {
    final String? url = currentUrl;
    if (_webViewController == null || url == null) return;
    emit(state.copyWith(progress: 0, statusState: StatusState.loading));
    await _webViewController?.loadRequest(Uri.parse(url));
  }

  void reload() async {
    if (_webViewController == null) return;
    emit(state.copyWith(progress: 0, statusState: StatusState.loading));
    await _webViewController?.reload();
  }
}
