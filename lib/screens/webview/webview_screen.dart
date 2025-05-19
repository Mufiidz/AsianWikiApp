import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../di/injection.dart';
import '../../res/constants/constants.dart';
import '../../utils/export_utils.dart';
import '../../widgets/export_widget.dart';
import 'cubit/webview_cubit.dart';

class WebviewScreen extends StatefulWidget {
  final String url;
  const WebviewScreen({required this.url, super.key});

  @override
  State<WebviewScreen> createState() => _WebviewScreenState();
}

class _WebviewScreenState extends State<WebviewScreen> {
  late final WebViewController _controller;
  late final WebviewCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = getIt<WebviewCubit>();
    _controller = WebViewController();
    _cubit.initial(_controller, widget.url);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, dynamic result) {
        if (didPop) return;
        _goBack();
      },
      child: Scaffold(
        appBar: AppbarWidget(
          appName,
          onBackPressed: _goBack,
          actions: <Widget>[
            IconButton(
              onPressed:
                  () => _cubit.loadUrl(),
              icon: const Icon(Icons.refresh),
            ),
          ],
        ),
        body: BlocBuilder<WebviewCubit, WebviewState>(
          bloc: _cubit,
          builder: (BuildContext context, WebviewState state) {
            logger.d(state);
            if (state.isLoading) {
              return Center(
                child: CircularProgressIndicator.adaptive(
                  value: state.progress,
                ),
              );
            }

            if (state.isError) {
              return Center(child: Text(state.message));
            }
            return WebViewWidget(controller: _controller);
          },
        ),
      ),
    );
  }

  void _goBack() async {
    if (await _controller.canGoBack()) {
      _controller.goBack();
    } else {
      AppRoute.back();
    }
  }
}
