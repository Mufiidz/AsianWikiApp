import 'package:flutter/material.dart';

import '../data/base_state.dart';
import 'export_widget.dart';

class BodyWidget<State extends BaseState> extends StatelessWidget {
  final State state;
  final bool? isError;
  final bool? isLoading;
  final Widget Function(BuildContext context, State state)? loadingBuilder;
  final Widget Function(BuildContext context, State state)? errorBuilder;
  final Widget Function(BuildContext context, State state) child;
  const BodyWidget({
    required this.state,
    required this.child,
    super.key,
    this.loadingBuilder,
    this.errorBuilder,
    this.isError,
    this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    final State(:String message, :StatusState statusState) = state;
    if (isLoading ?? state.isLoading) {
      return loadingBuilder?.call(context, state) ??
          const Center(child: CircularProgressIndicator.adaptive());
    }
    if (isError ?? state.isError) {
      return errorBuilder?.call(context, state) ??
          ErrorScreen(errorMessage: message);
    }
    return child(context, state);
  }
}
