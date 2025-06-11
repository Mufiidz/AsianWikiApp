import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../../res/locale_keys.g.dart';
import '../../../../styles/export_styles.dart';
import '../../../../utils/export_utils.dart';
import '../../../../widgets/list_widget.dart';

class BiographySection extends StatelessWidget {
  final List<String>? biographies;
  const BiographySection({super.key, this.biographies});

  @override
  Widget build(BuildContext context) {
    if (biographies == null || biographies?.isEmpty == true) {
      return const SizedBox.shrink();
    }
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
                LocaleKeys.biography.tr(),
                style: context.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacing.mediumSpacing,
              Builder(
                builder: (BuildContext context) {
                  if (biographies?.length == 1) {
                    return Text(
                      biographies?.first ?? '',
                      style: context.textTheme.bodyMedium,
                      textAlign: TextAlign.justify,
                    );
                  }
                  return Text.rich(
                    textAlign: TextAlign.justify,
                    TextSpan(
                      children: <InlineSpan>[
                        TextSpan(text: biographies?.first ?? ''),
                        TextSpan(
                          text: ' ${LocaleKeys.read_more.tr()}.',
                          style: TextStyle(color: context.colorScheme.primary),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => showModalBiography(context),
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

  void showModalBiography(BuildContext context) => showModalBottomSheet<void>(
    context: context,
    showDragHandle: true,
    builder: (BuildContext context) {
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: PaddingStyle.medium,
            vertical: PaddingStyle.small,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                LocaleKeys.biography.tr(),
                style: context.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacing.mediumSpacing,
              ListWidget<String>(
                biographies ?? <String>[],
                shrinkWrap: true,
                scrollPhysics: const NeverScrollableScrollPhysics(),
                isSeparated: true,
                itemBuilder:
                    (BuildContext context, String biography, int index) {
                      return Text(
                        biography,
                        style: context.textTheme.bodyMedium,
                        textAlign: TextAlign.justify,
                      );
                    },
                separatorBuilder:
                    (BuildContext context, String item, int index) =>
                        Spacing.smallSpacing,
              ),
            ],
          ),
        ),
      );
    },
  );
}
