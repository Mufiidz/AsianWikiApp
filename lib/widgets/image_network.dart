import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

import '../utils/app_context.dart';

typedef ProgressBuilder = Widget Function(double progress);
typedef ErrorBuilder = Widget Function(Object? error);

class ImageNetwork extends ExtendedImage {
  final String imageUrl;
  final BuildContext context;
  final ProgressBuilder? progressBuilder;
  final ErrorBuilder? errorBuilder;
  ImageNetwork(
    this.imageUrl,
    this.context, {
    super.key,
    super.fit,
    super.shape = BoxShape.rectangle,
    super.borderRadius,
    this.progressBuilder,
    this.errorBuilder,
    super.width,
    super.height,
  }) : super.network(
         imageUrl,
         clearMemoryCacheWhenDispose: true,
         loadStateChanged: (ExtendedImageState state) {
           return switch (state.extendedImageLoadState) {
             LoadState.completed => state.completedWidget,
             LoadState.loading => _loadingWidget(
               progressBuilder,
               state.loadingProgress,
             ),
             LoadState.failed =>
               errorBuilder?.call(state.lastException) ??
                   Icon(Icons.error, color: context.colorScheme.error),
           };
         },
       );

  static Widget _loadingWidget(
    ProgressBuilder? progressBuilder,
    ImageChunkEvent? loadingProgress,
  ) {
    final int? cumulativeBytesLoaded = loadingProgress?.cumulativeBytesLoaded;
    final int? expectedTotalBytes = loadingProgress?.expectedTotalBytes;

    if (cumulativeBytesLoaded != null && expectedTotalBytes != null) {
      final double progress = cumulativeBytesLoaded / expectedTotalBytes;
      return progressBuilder?.call(progress) ??
          Center(child: CircularProgressIndicator.adaptive(value: progress));
    }

    return const Center(child: CircularProgressIndicator.adaptive());
  }
}
