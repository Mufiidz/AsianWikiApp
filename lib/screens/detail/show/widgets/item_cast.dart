import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../model/cast_show.dart';
import '../../../../res/locale_keys.g.dart';
import '../../../../styles/export_styles.dart';
import '../../../../utils/export_utils.dart';
import '../../../../widgets/image_network.dart';
import '../../person/detail_person_screen.dart';

class ItemCast extends StatelessWidget {
  final CastShow cast;
  const ItemCast({required this.cast, super.key});

  @override
  Widget build(BuildContext context) {
    final CastShow(
      :String id,
      :String name,
      :String? imageUrl,
      :String? cast,
      :String profileUrl,
    ) = this.cast;
    const double imageSize = 70;
    return InkWell(
      borderRadius: CornerRadius.mediumRadius,
      onTap: () => AppRoute.to(DetailPersonScreen(person: this.cast.toPerson)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Builder(
            builder: (BuildContext context) {
              if (imageUrl == null || imageUrl.isEmpty) {
                return Container(
                  width: imageSize,
                  height: imageSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: context.colorScheme.surface,
                  ),
                  child: const Icon(Icons.person, size: (imageSize / 2)),
                );
              }
              return ImageNetwork(
                imageUrl,
                context,
                shape: BoxShape.circle,
                width: imageSize,
                height: imageSize,
              );
            },
          ),
          Spacing.smallSpacing,
          Flexible(
            child: Text(
              name,
              style: context.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Flexible(
            child: Text(
              '${LocaleKeys.as.tr()} ${cast ?? '-'}',
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
