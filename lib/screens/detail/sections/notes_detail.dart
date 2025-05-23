import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart';

import '../../../res/locale_keys.g.dart';
import '../../../styles/export_styles.dart';
import '../../../utils/export_utils.dart';

typedef OnTapUrl = void Function(String url, String? title);

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
              onTapUrl: _onTapUrl,
            ),
          ],
        ),
      ),
    );
  }

  FutureOr<bool> _onTapUrl(String url) {
    final String? urlText = _getTextsForUrl(notes ?? '', url);
    onTapUrl?.call(url, urlText);
    return true;
  }

  String? _getTextsForUrl(String htmlString, String targetUrl) {
    final dom.Document document = parse(htmlString);

    // Find all anchor elements
    final List<dom.Element> anchorElements = document.getElementsByTagName('a');

    // Filter anchors with matching href and collect inner text
    for (dom.Element element in anchorElements) {
      if (element.attributes['href'] == targetUrl) {
        return element.text.trim();
      }
    }

    return null; // if not found
  }
}
