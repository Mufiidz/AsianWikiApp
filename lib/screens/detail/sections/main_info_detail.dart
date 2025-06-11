import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../../../model/simple_data.dart';
import '../../../styles/export_styles.dart';
import '../../../utils/export_utils.dart';

class MainInfoDetail extends StatelessWidget {
  final List<SimpleData>? mainInfos;
  const MainInfoDetail({super.key, this.mainInfos});

  @override
  Widget build(BuildContext context) {
    final List<SimpleData>? mainInfos = this.mainInfos;
    if (mainInfos == null) return const SizedBox.shrink();
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
        children: mainInfos
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
