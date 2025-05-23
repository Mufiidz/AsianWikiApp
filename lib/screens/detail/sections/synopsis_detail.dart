import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../model/synopsis.dart';
import '../../../res/locale_keys.g.dart';
import '../../../styles/export_styles.dart';
import '../../../utils/export_utils.dart';

class SynopsisDetail extends StatelessWidget {
  final Synopsis? synopsis;
  const SynopsisDetail({this.synopsis, super.key});

  @override
  Widget build(BuildContext context) {
    final Synopsis? newSynopsis = synopsis;
    if (newSynopsis == null) return const SizedBox.shrink();
    final Synopsis(:String translated, :String original) = newSynopsis;
    return Card.filled(
      shape: RoundedRectangleBorder(borderRadius: CornerRadius.largeRadius),
      child: Padding(
        padding: const EdgeInsets.all(PaddingStyle.medium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              LocaleKeys.synopsis.tr(),
              style: context.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacing.mediumSpacing,
            Text(translated, style: context.textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}
