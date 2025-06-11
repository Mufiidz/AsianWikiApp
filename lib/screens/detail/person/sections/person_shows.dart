import 'package:flutter/material.dart';

import '../../../../model/person_show.dart';
import '../../../../styles/spacing.dart';
import '../../../../widgets/export_widget.dart';
import '../person_show_detail.dart';

class PersonShows extends StatelessWidget {
  final List<PersonShow>? personShows;
  const PersonShows({super.key, this.personShows});

  @override
  Widget build(BuildContext context) {
    final List<PersonShow>? personShows = this.personShows;
    if (personShows == null || personShows.isEmpty) {
      return const SizedBox.shrink();
    }
    return ListWidget<PersonShow>(
      personShows,
      shrinkWrap: true,
      scrollPhysics: const NeverScrollableScrollPhysics(),
      isSeparated: true,
      itemBuilder: (BuildContext context, PersonShow item, int index) =>
          PersonShowDetail(personShow: item),
      separatorBuilder: (BuildContext context, PersonShow item, int index) =>
          Spacing.spacing24,
    );
  }
}
