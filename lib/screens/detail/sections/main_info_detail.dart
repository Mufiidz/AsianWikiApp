import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../model/detail_drama.dart';
import '../../../model/simple_data.dart';
import '../../../res/locale_keys.g.dart';
import '../../../styles/export_styles.dart';
import '../../../utils/export_utils.dart';

class MainInfoDetail extends StatelessWidget {
  final DetailDrama? detailDrama;
  const MainInfoDetail({super.key, this.detailDrama});

  @override
  Widget build(BuildContext context) {
    final DetailDrama? detailDrama = this.detailDrama;
    if (detailDrama == null) return const SizedBox.shrink();
    final DetailDrama(
      :int vote,
      :int rating,
      :String director,
      :ShowType? type,
      :String country,
    ) = detailDrama;
    return SizedBox(
      width: context.mediaSize.width,
      child: GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          childAspectRatio: 2,
        ),
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children:
            <SimpleData>[
                  SimpleData(
                    title: LocaleKeys.title_rating.tr(
                      namedArgs: <String, String>{'vote': vote.toString()},
                    ),
                    content: '$rating%',
                  ),
                  SimpleData(
                    title: LocaleKeys.director.tr(),
                    content: director,
                  ),
                  SimpleData(title: LocaleKeys.country.tr(), content: country),
                  SimpleData(
                    title: LocaleKeys.show.tr(),
                    content: type?.name.capitalize() ?? '-',
                  ),
                ]
                .mapIndexed(
                  (int index, SimpleData item) =>
                      _mainContent(context, index, item.title, item.content),
                )
                .toList(),
      ),
    );
  }

  Widget _mainContent(
    BuildContext context,
    int index,
    String title,
    String data,
  ) => Container(
    padding: const EdgeInsets.all(PaddingStyle.medium),
    alignment: Alignment.center,
    decoration: BoxDecoration(borderRadius: CornerRadius.mediumRadius),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          data,
          style: context.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        Flexible(
          child: Text(
            title,
            style: context.textTheme.bodyMedium?.copyWith(fontSize: 12),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    ),
  );
}
