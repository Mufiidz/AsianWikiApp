import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../di/injection.dart';
import '../../model/option_setting.dart';
import '../../res/locale_keys.g.dart';
import '../../styles/export_styles.dart';
import '../../utils/export_utils.dart';
import '../../widgets/export_widget.dart';
import '../home/home_screen.dart';
import 'cubit/settings_cubit.dart';
import 'list_options.dart';
import 'option_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late final SettingsCubit _settingsCubit;

  @override
  void initState() {
    _settingsCubit = getIt<SettingsCubit>();
    super.initState();
    _settingsCubit.initial();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(LocaleKeys.settings.tr()),
      body: BlocConsumer<SettingsCubit, SettingsState>(
        listener: (BuildContext context, SettingsState state) {
          if (state.isSuccess) {
            context.snackbar.showSnackBar(
              SnackbarWidget(
                state.message,
                context,
                state: SnackbarState.success,
              ),
            );
            AppRoute.clearAll(const HomeScreen());
          }
          if (state.isError) {
            context.snackbar.showSnackBar(
              SnackbarWidget(
                state.message,
                context,
                state: SnackbarState.error,
              ),
            );
          }
        },
        builder: (BuildContext context, SettingsState state) => ListView(
          padding: PaddingStyle.paddingH16V8,
          physics: const BouncingScrollPhysics(),
          children: <Widget>[
            ListTile(
              title: Text(LocaleKeys.language.tr()),
              subtitle: Text(
                '${context.locale.toString().countryName} (${context.locale.toString().toUpperCase()})',
              ),
              leading: Text(
                context.locale.toString().countryCodeToEmoji(),
                style: const TextStyle(fontSize: 24),
              ),
              onTap: () => _changeLanguage(context, state.selectedLang),
            ),
            ListTile(
              title: Text(LocaleKeys.themes.tr()),
              subtitle: Text(
                '${state.selectedTheme.name.capitalizeFirst()} Mode.',
              ),
              leading: ListOptions.themes()
                  .firstWhere(
                    (OptionSetting<ThemeMode> option) =>
                        option.value == state.selectedTheme,
                  )
                  .icon,
              onTap: () => _changeTheme(context, state.selectedTheme),
            ),
          ],
        ),
      ),
    );
  }

  void _changeLanguage(BuildContext context, String selectedLang) async {
    final dynamic newSelectedLang = await AppRoute.to(
      OptionScreen<String>(
        options: ListOptions.languages(context),
        selectedValue: selectedLang.whenEmpty(
          defaultValue: context.locale.toString(),
        ),
        title: LocaleKeys.title_choose_language.tr(),
      ),
    );
    if (newSelectedLang == null ||
        newSelectedLang is! String ||
        newSelectedLang.isEmpty) {
      return;
    }

    if (!context.mounted) return;

    _settingsCubit.changeLanguage(context, newSelectedLang);
  }

  void _changeTheme(BuildContext context, ThemeMode selectedTheme) async {
    final dynamic newSelectedTheme = await AppRoute.to(
      OptionScreen<ThemeMode>(
        options: ListOptions.themes(),
        selectedValue: selectedTheme,
        title: LocaleKeys.title_choose_theme.tr(),
      ),
    );
    if (newSelectedTheme == null || newSelectedTheme is! ThemeMode) {
      return;
    }

    if (!context.mounted) return;

    _settingsCubit.changeThemeMode(newSelectedTheme);
  }
}
