import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../model/option_setting.dart';
import '../../res/locale_keys.g.dart';
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

  static List<OptionSetting<ThemeMode>> themes() => <OptionSetting<ThemeMode>>[
    OptionSetting<ThemeMode>(
      ThemeMode.system,
      title: LocaleKeys.title_theme_system.tr(),
      subtitle: LocaleKeys.subtitle_theme_system.tr(),
      icon: const Icon(Icons.contrast),
    ),
    OptionSetting<ThemeMode>(
      ThemeMode.light,
      title: LocaleKeys.title_theme_light.tr(),
      icon: const Icon(Icons.light_mode),
    ),
    OptionSetting<ThemeMode>(
      ThemeMode.dark,
      title: LocaleKeys.title_theme_dark.tr(),
      icon: const Icon(Icons.dark_mode),
    ),
  ];
}
