import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../model/option_setting.dart';
import '../../res/locale_keys.g.dart';
import '../../styles/export_styles.dart';
import '../../utils/export_utils.dart';
import '../../widgets/export_widget.dart';

class OptionScreen<OPTION> extends StatefulWidget {
  final String? title;
  final List<OptionSetting<OPTION>> options;
  final OPTION selectedValue;
  const OptionScreen({
    required this.options,
    required this.selectedValue,
    this.title,
    super.key,
  });

  @override
  State<OptionScreen<OPTION>> createState() => _OptionScreenState<OPTION>();
}

class _OptionScreenState<OPTION> extends State<OptionScreen<OPTION>> {
  OPTION? _groupValue;

  @override
  void initState() {
    _groupValue ??= widget.selectedValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(
        widget.title ?? LocaleKeys.settings.tr(),
        showBackButton: true,
        onBackPressed: () => AppRoute.back(_groupValue),
      ),
      body: PopScope(
        canPop: false,
        onPopInvokedWithResult: (bool didPop, dynamic result) {
          if (didPop) return;
          AppRoute.back(_groupValue);
        },
        child: Card.filled(
          margin: PaddingStyle.paddingH16V8,
          shape: RoundedRectangleBorder(borderRadius: CornerRadius.largeRadius),
          child: RadioGroup<OPTION>(
            groupValue: _groupValue,
            onChanged: (OPTION? value) => setState(() => _groupValue = value),
            child: ListWidget<OptionSetting<OPTION>>(
              widget.options,
              isSeparated: true,
              shrinkWrap: true,
              padding: PaddingStyle.screen,
              scrollPhysics: const NeverScrollableScrollPhysics(),
              itemBuilder:
                  (
                    BuildContext context,
                    OptionSetting<OPTION> item,
                    int index,
                  ) {
                    final OptionSetting<OPTION>(
                      :String title,
                      :String? subtitle,
                      :Widget? icon,
                      :OPTION value,
                    ) = item;
                    return ListTile(
                      title: Text(title),
                      subtitle: subtitle != null ? Text(subtitle) : null,
                      leading: icon,
                      trailing: Radio<OPTION>.adaptive(value: value),
                      onTap: () {
                        setState(() => _groupValue = value);
                        AppRoute.back(_groupValue);
                      },
                    );
                  },
              separatorBuilder:
                  (
                    BuildContext context,
                    OptionSetting<OPTION> item,
                    int index,
                  ) => const Divider(),
            ),
          ),
        ),
      ),
    );
  }
}
