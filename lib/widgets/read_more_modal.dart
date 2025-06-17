import 'package:flutter/material.dart';

import '../styles/export_styles.dart';
import '../utils/export_utils.dart';
import 'export_widget.dart';

void readMoreModal(
  BuildContext context,
  List<String>? contents,
  String title,
) => showModalBottomSheet<void>(
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
              title,
              style: context.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacing.mediumSpacing,
            ListWidget<String>(
              contents ?? <String>[],
              shrinkWrap: true,
              scrollPhysics: const NeverScrollableScrollPhysics(),
              isSeparated: true,
              itemBuilder: (BuildContext context, String content, int index) {
                return Text(
                  content,
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
