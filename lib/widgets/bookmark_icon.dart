import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../res/export_res.dart';
import '../utils/export_utils.dart';

typedef BookmarkController = AnimationController;

class BookmarkIcon extends StatefulWidget {
  final bool isBookmark;
  final BookmarkController bookmarkController;
  const BookmarkIcon({
    required this.isBookmark,
    required this.bookmarkController,
    super.key,
  });

  @override
  State<BookmarkIcon> createState() => _BookmarkIconState();
}

class _BookmarkIconState extends State<BookmarkIcon> {
  bool _isAnimatedBookmark = false;
  late BookmarkController _bookmarkController;

  @override
  void initState() {
    super.initState();
    _bookmarkController = widget.bookmarkController;

    AssetLottie(Assets.lottie.bookmark.path).load().then((
      LottieComposition composition,
    ) {
      _bookmarkController.duration = composition.duration;
    });

    _bookmarkController.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        setState(() => _isAnimatedBookmark = false);
      }

      if (status == AnimationStatus.forward) {
        setState(() {
          _isAnimatedBookmark = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isBookmark = widget.isBookmark;
    return OverflowBox(
      maxHeight: 40,
      maxWidth: 40,
      child: Builder(
        builder: (BuildContext context) {
          if (_isAnimatedBookmark) {
            return ColorFiltered(
              colorFilter: ColorFilter.mode(
                context.colorScheme.primary,
                BlendMode.srcIn,
              ),
              child: Assets.lottie.bookmark.lottie(
                controller: _bookmarkController,
              ),
            );
          }
          return Icon(
            isBookmark ? Icons.bookmark_rounded : Icons.bookmark_border_rounded,
            color: isBookmark ? context.colorScheme.primary : null,
          );
        },
      ),
    );
  }
}
