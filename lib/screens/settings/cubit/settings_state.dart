part of 'settings_cubit.dart';

@MappableClass()
class SettingsState extends BaseState with SettingsStateMappable {
  final String selectedLang;
  final ThemeMode selectedTheme;

  SettingsState({
    super.message,
    super.statusState,
    this.selectedLang = '',
    this.selectedTheme = ThemeMode.system,
  });
}
