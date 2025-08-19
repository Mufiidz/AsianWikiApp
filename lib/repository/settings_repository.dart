import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/base_result.dart';
import '../res/constants/sharedpref_keys.dart' as sharedpref_keys;
import '../res/locale_keys.g.dart';
import '../utils/export_utils.dart';

abstract class SettingsRepository {
  Future<BaseResult<String>> changeLanguage(
    BuildContext context,
    String languageCode,
  );
  Future<void> saveThemeMode(ThemeMode themeMode);
  Future<ThemeMode> getThemeMode();
}

@Injectable(as: SettingsRepository)
class SettingsRepositoryImpl implements SettingsRepository {
  final SharedPreferencesWithCache _sharedPreferences;

  SettingsRepositoryImpl(this._sharedPreferences);

  @override
  Future<BaseResult<String>> changeLanguage(
    BuildContext context,
    String? languageCode,
  ) async {
    try {
      final Locale defaultLocale = context.locale;
      final Locale locale = Locale(languageCode ?? defaultLocale.languageCode);

      if (!context.mounted || locale == defaultLocale) {
        return DataResult<String>('');
      }
      await context.setLocale(locale);
      return DataResult<String>(LocaleKeys.success_msg_language.tr());
    } catch (e) {
      logger.e(e);
      return ErrorResult<String>(LocaleKeys.error_msg_language.tr());
    }
  }

  @override
  Future<ThemeMode> getThemeMode() async {
    final String theme =
        _sharedPreferences.getString(sharedpref_keys.theme) ??
        ThemeMode.system.name;
    return ThemeMode.values.firstWhere((ThemeMode e) => e.name == theme);
  }

  @override
  Future<void> saveThemeMode(ThemeMode themeMode) async =>
      _sharedPreferences.setString(sharedpref_keys.theme, themeMode.name);
}
