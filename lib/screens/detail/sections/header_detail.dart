import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../res/export_res.dart';
import '../../../styles/padding.dart';
import '../../../utils/export_utils.dart';
import '../../../widgets/export_widget.dart';

typedef OnClickFavorite = void Function()?;

class HeaderDetail extends StatefulWidget {
  final String heroId;
  final String image;
  final String title;
  final OnClickFavorite onClickFavorite;
  final FavoriteController favoriteController;
  const HeaderDetail({
    required this.image,
    required this.title,
    required this.heroId,
    required this.favoriteController,
    super.key,
    this.onClickFavorite,
  });

  @override
  State<HeaderDetail> createState() => _HeaderDetailState();
}

class _HeaderDetailState extends State<HeaderDetail> {
  bool isImgLoaded = true;
  bool _isAnimatedFavorite = false;
  late FavoriteController _favoriteController;
  LottieComposition? _composition;

  @override
  void initState() {
    _favoriteController = widget.favoriteController;
    super.initState();

    AssetLottie(Assets.lottie.favorite2.path)
        .load()
        .then((LottieComposition composition) {
          _composition = composition;
          final Duration duration =
              composition.duration -
              const Duration(seconds: 1, milliseconds: 800);
          logger.d(duration);
          _favoriteController.duration = duration;
          _favoriteController.reverseDuration = duration;
        })
        .catchError(logger.e);

    _favoriteController.addStatusListener((AnimationStatus status) {
      setState(() {
        _isAnimatedFavorite = status.isAnimating;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.image.isEmpty || widget.title.isEmpty) {
      return const SizedBox.shrink();
    }
    return Column(
      children: <Widget>[
        ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(48),
            bottomRight: Radius.circular(48),
          ),
          child: Hero(
            tag: widget.heroId,
            child: GestureDetector(
              onDoubleTap: widget.onClickFavorite,
              child: SizedBox(
                width: context.mediaSize.width,
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    ImageNetwork(
                      widget.image,
                      context,
                      fit: BoxFit.cover,
                      errorBuilder: (Object? error) => Container(
                        width: context.mediaSize.width,
                        height: kToolbarHeight + 20,
                        alignment: Alignment.center,
                        child: Text(error.toString()),
                      ),
                    ),
                    Visibility(
                      visible: _isAnimatedFavorite,
                      child: ColorFiltered(
                        colorFilter: const ColorFilter.mode(
                          CustomColors.redHeart,
                          BlendMode.modulate,
                        ),
                        child: Assets.lottie.favorite2.lottie(
                          controller: _favoriteController,
                          alignment: Alignment.center,
                          width: _composition != null
                              ? _composition!.bounds.width.toDouble() * 3
                              : null,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: PaddingStyle.large,
            right: PaddingStyle.medium,
            left: PaddingStyle.medium,
            bottom: PaddingStyle.medium,
          ),
          child: Text(
            widget.title,
            textAlign: TextAlign.center,
            style: context.textTheme.headlineLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
