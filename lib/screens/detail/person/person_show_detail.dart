import 'package:flutter/material.dart';

import '../../../model/person_show.dart';
import '../../../styles/export_styles.dart';
import '../../../utils/export_utils.dart';
import '../../../widgets/list_widget.dart';
import 'widgets/item_personshow_widget.dart';

class PersonShowDetail extends StatelessWidget {
  final PersonShow personShow;
  const PersonShowDetail({required this.personShow, super.key});

  @override
  Widget build(BuildContext context) {
    final PersonShow(:String titleSection, :List<ItemPersonShow> items) =
        personShow;
    return Card.filled(
      shape: RoundedRectangleBorder(borderRadius: CornerRadius.largeRadius),
      child: Padding(
        padding: const EdgeInsets.all(PaddingStyle.medium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              titleSection,
              style: context.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacing.mediumSpacing,
            ListWidget<ItemPersonShow>(
              items,
              shrinkWrap: true,
              scrollPhysics: const NeverScrollableScrollPhysics(),
              isSeparated: true,
              itemBuilder:
                  (BuildContext context, ItemPersonShow item, int index) =>
                      ItemPersonShowWidget(personShow: item),
              separatorBuilder:
                  (BuildContext context, ItemPersonShow item, int index) =>
                      const Divider(),
            ),
          ],
        ),
      ),
    );
  }
}
