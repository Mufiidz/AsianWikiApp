import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import '../data/base_result.dart';

import '../res/locale_keys.g.dart';
import '../utils/export_utils.dart';

abstract class SettingsRepository {
  Future<BaseResult<String>> changeLanguage(
    BuildContext context,
    String languageCode,
  );
}

@Injectable(as: SettingsRepository)
class SettingsRepositoryImpl implements SettingsRepository {
  SettingsRepositoryImpl();

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
      logger.e(e, tag: 'changeLanguage');
      return ErrorResult<String>(LocaleKeys.error_msg_language.tr());
    }
  }
}
