import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../model/person_show.dart';
import '../../../../model/show.dart';
import '../../../../res/locale_keys.g.dart';
import '../../../../utils/export_utils.dart';
import '../../show/detail_show_screen.dart';

class ItemPersonShowWidget extends StatelessWidget {
  final ItemPersonShow personShow;
  const ItemPersonShowWidget({required this.personShow, super.key});

  @override
  Widget build(BuildContext context) {
    final ItemPersonShow(:String id, :String title, :String cast, :int year) =
        personShow;
    return ListTile(
      title: Text(title, style: context.textTheme.titleMedium),
      subtitle: Text('${LocaleKeys.as.tr()} $cast'),
      trailing: Text('$year'),
      onTap: () => AppRoute.to(
        DetailShowScreen(
          drama: Show(id: id, title: title),
        ),
      ),
    );
  }
}
