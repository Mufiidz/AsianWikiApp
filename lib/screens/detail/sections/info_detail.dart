import 'package:flutter/material.dart';

import '../../../model/simple_data.dart';
import '../../../styles/export_styles.dart';
import '../../../widgets/export_widget.dart';

class InfoDetail extends StatelessWidget {
  final List<SimpleData>? infos;
  const InfoDetail({required this.infos, super.key});

  @override
  Widget build(BuildContext context) {
    List<SimpleData>? infos = this.infos;
    if (infos == null || infos.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(
        bottom: PaddingStyle.padding24,
        left: PaddingStyle.medium,
        right: PaddingStyle.medium,
      ),
      child: ListWidget<SimpleData>(
        infos,
        shrinkWrap: true,
        scrollPhysics: const NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, SimpleData item, int index) => Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(child: Text(item.title)),
            const Text(' : '),
            Expanded(flex: 2, child: Text(item.content)),
          ],
        ),
      ),
    );
  }
}
