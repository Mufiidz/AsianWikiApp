import 'package:flutter/material.dart';

import '../../model/favorite.dart';
import '../../styles/export_styles.dart';
import '../../utils/export_utils.dart';
import '../../widgets/export_widget.dart';

typedef OnClickFavorite = void Function(Favorite favorite);

class ItemFavorite extends StatelessWidget {
  final Favorite favorite;
  final bool showTag;
  final OnClickFavorite? onClick;
  const ItemFavorite({
    required this.favorite,
    super.key,
    this.showTag = false,
    this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    final Favorite(:String title, :String type, :String imageUrl, :String id) =
        favorite;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: CornerRadius.mediumRadius),
      elevation: Elevation.small,
      child: ClipRRect(
        borderRadius: CornerRadius.mediumRadius,
        child: InkWell(
          onTap: () => onClick?.call(favorite),
          borderRadius: CornerRadius.mediumRadius,
          child: Stack(
            children: <Widget>[
              Hero(
                tag: id,
                child: ImageNetwork(
                  imageUrl,
                  context,
                  borderRadius: CornerRadius.mediumRadius,
                  fit: BoxFit.cover,
                  width: context.mediaSize.width,
                  height: context.mediaSize.height,
                ),
              ),
              Visibility(
                visible: showTag,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: PaddingStyle.medium,
                      vertical: 2,
                    ),
                    decoration: const BoxDecoration(
                      color: Colors.black45,
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(CornerRadius.medium),
                      ),
                    ),
                    child: Text(
                      type.toTitleCase().whenEmpty(),
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                width: context.mediaSize.width,
                height: context.mediaSize.height,
                alignment: Alignment.bottomCenter,
                padding: PaddingStyle.paddingH8V16,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: <Color>[
                      Colors.transparent,
                      Colors.black45,
                      Colors.black,
                    ],
                  ),
                ),
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: Colors.white,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
