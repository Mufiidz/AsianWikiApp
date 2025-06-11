import 'package:flutter/material.dart';

import '../../../../data/network/cast_response.dart';
import '../../../../model/cast_show.dart';
import '../../../../styles/export_styles.dart';
import '../../../../utils/export_utils.dart';
import 'item_cast.dart';

class CastDetail extends StatelessWidget {
  final CastResponse cast;
  const CastDetail({required this.cast, super.key});

  @override
  Widget build(BuildContext context) {
    final CastResponse(:String title, :List<CastShow> casts) = cast;
    return Card.filled(
      shape: RoundedRectangleBorder(borderRadius: CornerRadius.largeRadius),
      child: Padding(
        padding: const EdgeInsets.all(PaddingStyle.medium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SelectableText(
              title,
              style: context.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacing.mediumSpacing,
            GridView.builder(
              itemCount: casts.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: context.mediaSize.width > 600 ? 4 : 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              itemBuilder: (BuildContext context, int index) {
                final CastShow cast = casts[index];
                return ItemCast(cast: cast);
              },
            ),
          ],
        ),
      ),
    );
  }
}
