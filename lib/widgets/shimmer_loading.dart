import 'package:flutter/material.dart';

import '../utils/app_context.dart';
import 'shimmer.dart';

class ShimmerLoading extends StatefulWidget {
  final bool isLoading;
  final Widget child;

  const ShimmerLoading({
    required this.isLoading,
    required this.child,
    super.key,
  });

  @override
  State<ShimmerLoading> createState() => _ShimmerLoadingState();
}

class _ShimmerLoadingState extends State<ShimmerLoading> {
  ShimmerState? _shimmer;
  Listenable? _shimmerChanges;

  @override
  void initState() {
    super.initState();
    _shimmer = context.shimmer;
  }
  @override
  Widget build(BuildContext context) {
    Widget child = widget.child;
    ShimmerState? shimmer = _shimmer;
    if (!widget.isLoading) return child;

    if (shimmer == null || !shimmer.isSized) {
      // The ancestor Shimmer widget isn't laid
      // out yet. Return an empty box.
      return const SizedBox.shrink();
    }
    final Size shimmerSize = shimmer.size;
    final Gradient gradient = shimmer.gradient;
    final Offset offsetWithinShimmer = shimmer.getDescendantOffset(
      descendant: context.findRenderObject() as RenderBox,
    );

    return ShaderMask(
      blendMode: BlendMode.srcATop,
      shaderCallback:
          (Rect bounds) => gradient.createShader(
            Rect.fromLTWH(
              -offsetWithinShimmer.dx,
              -offsetWithinShimmer.dy,
              shimmerSize.width,
              shimmerSize.height,
            ),
          ),
      child: child,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_shimmerChanges != null) {
      _shimmerChanges!.removeListener(_onShimmerChange);
    }
    _shimmerChanges = _shimmer?.shimmerChanges;
    if (_shimmerChanges != null) {
      _shimmerChanges!.addListener(_onShimmerChange);
    }
  }

  @override
  void dispose() {
    _shimmerChanges?.removeListener(_onShimmerChange);
    super.dispose();
  }

  void _onShimmerChange() {
    if (widget.isLoading) {
      setState(() {});
    }
  }
}
