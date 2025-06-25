import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../res/export_res.dart';

typedef FavoriteController = AnimationController;

class FavoriteIcon extends StatefulWidget {
  final bool isFavorite;
  final FavoriteController favoriteController;
  const FavoriteIcon({
    required this.isFavorite,
    required this.favoriteController,
    super.key,
  });

  @override
  State<FavoriteIcon> createState() => _FavoriteIconState();
}

class _FavoriteIconState extends State<FavoriteIcon> {
  bool _isAnimatedFavorite = false;
  late AnimationController _favoriteController;

  @override
  void initState() {
    super.initState();
    _favoriteController = widget.favoriteController;

    AssetLottie(Assets.lottie.favorite.path).load().then((
      LottieComposition composition,
    ) {
      _favoriteController.duration = composition.duration;
    });

    _favoriteController.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        setState(() => _isAnimatedFavorite = false);
      }

      if (status == AnimationStatus.forward) {
        setState(() {
          _isAnimatedFavorite = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isFavorite = widget.isFavorite;
    return OverflowBox(
      maxHeight: 90,
      maxWidth: 90,
      child: Builder(
        builder: (BuildContext context) {
          if (_isAnimatedFavorite) {
            return Assets.lottie.favorite.lottie(
              controller: _favoriteController,
            );
          }
          return Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border,
            color: isFavorite ? CustomColors.redHeart : null,
          );
        },
      ),
    );
  }
}
