import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../model/option_setting.dart';
import '../../utils/export_utils.dart';

class ListOptions {
  ListOptions._();
  static List<OptionSetting<String>> languages(BuildContext context) => context
      .supportedLocales
      .map((Locale locale) => locale.languageCode)
      .map(
        (String e) => OptionSetting<String>(
          e,
          title: '${e.countryName} (${e.toUpperCase()})',
          icon: Text(
            e.countryCodeToEmoji(),
            style: const TextStyle(fontSize: 24),
          ),
        ),
      )
      .toList();
}
