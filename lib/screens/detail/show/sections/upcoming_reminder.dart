import 'package:flutter/material.dart';

import '../../../../res/export_res.dart';
import '../../../../styles/export_styles.dart';
import '../../../../utils/export_utils.dart';

typedef OnClick = void Function()?;

class UpcomingReminder extends StatelessWidget {
  final bool showReminder;
  final bool isSetReminder;
  final OnClick onClick;
  const UpcomingReminder({
    super.key,
    this.showReminder = false,
    this.isSetReminder = false,
    this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    if (!showReminder) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(
        bottom: PaddingStyle.padding24,
        left: PaddingStyle.medium,
        right: PaddingStyle.medium,
      ),
      child: ElevatedButton.icon(
        onPressed: onClick,
        icon: Icon(
          isSetReminder ? Icons.notifications : Icons.notifications_off,
        ),
        label: Text(
          isSetReminder
              ? LocaleKeys.btn_reminder_upcoming.tr()
              : LocaleKeys.dismiss.tr(),
        ),
        style: ElevatedButton.styleFrom(
          foregroundColor: isSetReminder == false
              ? context.colorScheme.error
              : null,
        ),
      ),
    );
  }
}
