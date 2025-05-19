import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import '../../../res/locale_keys.g.dart';
import '../../../styles/export_styles.dart';
import '../../../utils/export_utils.dart';

typedef OnTapUrl = Function(String url);

class NotesDetail extends StatelessWidget {
  final String? notes;
  final OnTapUrl? onTapUrl;
  const NotesDetail({this.notes, super.key, this.onTapUrl});

  @override
  Widget build(BuildContext context) {
    if (notes == null || notes?.isEmpty == true) return const SizedBox.shrink();
    return Card.filled(
      shape: RoundedRectangleBorder(borderRadius: CornerRadius.largeRadius),
      child: Padding(
        padding: const EdgeInsets.all(PaddingStyle.medium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              LocaleKeys.notes.tr(),
              style: context.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacing.mediumSpacing,
            HtmlWidget(
              notes ?? '',
              // ignore: always_specify_types
              customStylesBuilder: (element) {
                if (element.attributes.containsKey('href')) {
                  return <String, String>{'color': '#008CE3'};
                }
                return null;
              },
              onTapUrl: (String url) async {
                onTapUrl?.call(url);
                return true;
              },
            ),
          ],
        ),
      ),
    );
  }
}
