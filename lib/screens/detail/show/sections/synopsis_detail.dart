import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../../res/locale_keys.g.dart';
import '../../../../styles/export_styles.dart';
import '../../../../utils/export_utils.dart';

class SynopsisDetail extends StatelessWidget {
  final List<String>? synopsis;
  const SynopsisDetail({this.synopsis, super.key});

  @override
  Widget build(BuildContext context) {
    List<String> synopsis = this.synopsis ?? <String>[];
    if (synopsis.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(bottom: PaddingStyle.padding24),
      child: Card.filled(
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
              Builder(
                builder: (BuildContext context) {
                  if (synopsis.length == 1) {
                    return Text(
                      synopsis.first,
                      style: context.textTheme.bodyMedium,
                      textAlign: TextAlign.justify,
                    );
                  }
                  return Text.rich(
                    textAlign: TextAlign.justify,
                    TextSpan(
                      children: <InlineSpan>[
                        TextSpan(text: synopsis.first),
                        TextSpan(
                          text: ' ${LocaleKeys.read_more.tr()}.',
                          style: TextStyle(color: context.colorScheme.primary),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => context.showReadMoreModal(synopsis, LocaleKeys.synopsis.tr()),
                        ),
                      ],
                    ),
                    style: context.textTheme.bodyMedium,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
