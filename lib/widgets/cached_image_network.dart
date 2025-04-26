import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../utils/export_utils.dart';

class CachedImageNetwork extends CachedNetworkImage {
  final String url;
  final ProgressIndicatorBuilder? loadingBuilder;
  final LoadingErrorWidgetBuilder? errorBuilder;
  final ValueChanged<Object>? onError;

  CachedImageNetwork(
    this.url, {
    super.key,
    super.fit,
    super.width,
    super.height,
    this.loadingBuilder,
    this.errorBuilder,
    this.onError,
  }) : super(
         imageUrl: url,
         progressIndicatorBuilder:
             loadingBuilder ??
             (BuildContext context, String url, DownloadProgress progress) =>
                 Center(
                   child: CircularProgressIndicator(value: progress.progress),
                 ),
         errorWidget:
             errorBuilder ??
             (BuildContext context, String url, Object error) =>
                 Icon(Icons.error, color: context.colorScheme.error),
         errorListener:
             onError ??
             (Object value) => logger.e('CachedImageNetwork Error: $value'),
       );
}
