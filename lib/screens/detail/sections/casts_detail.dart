import 'package:flutter/material.dart';

import '../../../data/network/cast_response.dart';
import '../../../widgets/export_widget.dart';
import '../widgets/cast_detail.dart';

class CastsDetail extends StatelessWidget {
  final List<CastResponse> casts;
  const CastsDetail({required this.casts, super.key});

  @override
  Widget build(BuildContext context) {
    if (casts.isEmpty) return const SizedBox.shrink();
    return ListWidget<CastResponse>(
      casts,
      shrinkWrap: true,
      scrollPhysics: const NeverScrollableScrollPhysics(),
      isSeparated: true,
      itemBuilder:
          (BuildContext context, CastResponse item, int index) =>
              CastDetail(cast: item),
      separatorBuilder:
          (BuildContext context, CastResponse item, int index) =>
              const SizedBox(height: 24),
    );
  }
}
