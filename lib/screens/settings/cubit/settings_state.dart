part of 'settings_cubit.dart';

@MappableClass()
class SettingsState extends BaseState with SettingsStateMappable {
  final String selectedLang;
  SettingsState({super.message, super.statusState, this.selectedLang = ''});
}
