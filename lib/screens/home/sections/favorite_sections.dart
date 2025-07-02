import 'package:flutter/material.dart';

import '../../../model/favorite.dart';
import '../../../res/export_res.dart';
import '../../../styles/export_styles.dart';
import '../../../utils/export_utils.dart';
import '../../../widgets/export_widget.dart';

typedef OnTapFavorite = void Function(Favorite favorite);
typedef OnTapSeeAll = void Function();

class FavoriteSections extends StatelessWidget {
  final List<Favorite> favorites;
  final FavoriteType type;
  final OnTapFavorite? onTapFavorite;
  final OnTapSeeAll? onTapSeeAll;
  const FavoriteSections(
    this.favorites,
    this.type, {
    super.key,
    this.onTapFavorite,
    this.onTapSeeAll,
  });

  @override
  Widget build(BuildContext context) {
    if (favorites.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: PaddingStyle.screen,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                LocaleKeys.title_favorite_type_sections.tr(
                  namedArgs: <String, String>{
                    'type': type.name.toTitleCase().whenEmpty(
                      defaultValue: '-',
                    ),
                  },
                ),
                style: context.textTheme.titleLarge,
              ),
              Visibility(
                visible: favorites.length > 5,
                child: FilledButton.tonal(
                  onPressed: onTapSeeAll,
                  child: Text(LocaleKeys.see_all.tr()),
                ),
              ),
            ],
          ),
        ),
        Spacing.mediumSpacing,
        SizedBox(
          height: 250,
          child: ListWidget<Favorite>(
            favorites,
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
                        Hero(
                          tag: item.id,
                          child: ImageNetwork(
                            item.imageUrl,
                            context,
                            width: double.infinity,
                            height: 190,
                            fit: BoxFit.cover,
                            borderRadius: CornerRadius.mediumRadius,
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
                    Spacing.mediumHSpacing,
          ),
        ),
      ],
    );
  }
}
