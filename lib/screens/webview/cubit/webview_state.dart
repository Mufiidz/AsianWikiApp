part of 'webview_cubit.dart';

@MappableClass()
class WebviewState extends BaseState with WebviewStateMappable {
  final double progress;

  WebviewState({super.message, super.statusState, this.progress = 0});
}
