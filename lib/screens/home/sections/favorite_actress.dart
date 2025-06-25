import 'package:flutter/material.dart';

import '../../../model/favorite.dart';
import '../../../res/export_res.dart';
import '../../../styles/export_styles.dart';
import '../../../utils/export_utils.dart';
import '../../../widgets/export_widget.dart';

typedef OnTapFavorite = void Function(Favorite favorite);

class FavoriteActress extends StatelessWidget {
  final List<Favorite> favoriteActress;
  final OnTapFavorite? onTapFavorite;
  const FavoriteActress(this.favoriteActress, {super.key, this.onTapFavorite});

  @override
  Widget build(BuildContext context) {
    if (favoriteActress.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: PaddingStyle.screen,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                LocaleKeys.title_favorite_actress_sections.tr(),
                style: context.textTheme.titleLarge,
              ),
              // FilledButton.tonal(
              //   onPressed: () {},
              //   child: const Text('View all'),
              // ),
            ],
          ),
        ),
        Spacing.mediumSpacing,
        SizedBox(
          height: 230,
          child: ListWidget<Favorite>(
            favoriteActress,
            isHorizontal: true,
            padding: PaddingStyle.mediumHorizontal,
            isSeparated: true,
            itemBuilder: (BuildContext context, Favorite item, int index) =>
                SizedBox(
                  width: 160,
                  child: InkWell(
                    onTap: () => onTapFavorite?.call(item),
                    borderRadius: CornerRadius.mediumRadius,
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          child: Hero(
                            tag: item.id,
                            child: ImageNetwork(
                              item.imageUrl,
                              context,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              borderRadius: CornerRadius.mediumRadius,
                            ),
                          ),
                        ),
                        Spacing.mediumSpacing,
                        Text(
                          item.title,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          style: context.textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ),
            separatorBuilder:
                (BuildContext context, Favorite item, int index) =>
                    const SizedBox(width: 16),
          ),
        ),
      ],
    );
  }
}
