import 'package:flutter/material.dart';

import 'shimmer_loading.dart';

class Shimmer extends StatefulWidget {
  final bool isLoading;
  final Widget? child;
  const Shimmer({required this.isLoading, super.key, this.child});

  static ShimmerState? of(BuildContext context) {
    return context.findAncestorStateOfType<ShimmerState>();
  }

  @override
  State<Shimmer> createState() => ShimmerState();
}

class ShimmerState extends State<Shimmer> with TickerProviderStateMixin {
  late AnimationController _shimmerController;

  @override
  void initState() {
    super.initState();
    _shimmerController = AnimationController.unbounded(vsync: this)
      ..repeat(min: -0.5, max: 1.5, period: const Duration(milliseconds: 1000));
  }

  @override
  void dispose() {
    _shimmerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget? child = widget.child;
    if (child == null) return const SizedBox.shrink();

    return ShimmerLoading(isLoading: widget.isLoading, child: child);
  }

  Listenable get shimmerChanges => _shimmerController;

  Gradient get gradient => LinearGradient(
    colors: _shimmerGradient.colors,
    stops: _shimmerGradient.stops,
    begin: _shimmerGradient.begin,
    end: _shimmerGradient.end,
    transform: _SlidingGradientTransform(
      slidePercent: _shimmerController.value,
    ),
  );

  bool get isSized =>
      (context.findRenderObject() as RenderBox?)?.hasSize ?? false;

  Size get size => (context.findRenderObject() as RenderBox).size;

  Offset getDescendantOffset({
    required RenderBox descendant,
    Offset offset = Offset.zero,
  }) {
    final RenderBox shimmerBox = context.findRenderObject() as RenderBox;
    return descendant.localToGlobal(offset, ancestor: shimmerBox);
  }

  LinearGradient get _shimmerGradient => const LinearGradient(
    colors: <Color>[
      Color(0xFF2C2C2E),
      Color(0xFF3A3A3C),
      Color(0xFF2C2C2E),
    ],
    stops: <double>[0.1, 0.3, 0.4],
    begin: Alignment(-1.0, -0.3),
    end: Alignment(1.0, 0.3),
    tileMode: TileMode.clamp,
  );
}

class _SlidingGradientTransform extends GradientTransform {
  const _SlidingGradientTransform({required this.slidePercent});

  final double slidePercent;

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    return Matrix4.translationValues(bounds.width * slidePercent, 0.0, 0.0);
  }
}
