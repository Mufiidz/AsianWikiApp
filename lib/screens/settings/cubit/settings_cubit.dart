import 'package:bloc/bloc.dart';
import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../../data/base_result.dart';
import '../../../data/base_state.dart';
import '../../../repository/settings_repository.dart';

part 'settings_state.dart';
part 'settings_cubit.mapper.dart';

@injectable
class SettingsCubit extends Cubit<SettingsState> {
  final SettingsRepository _settingsRepository;
  SettingsCubit(this._settingsRepository) : super(SettingsState());

  void changeLanguage(BuildContext context, String languageCode) async {
    emit(state.copyWith(statusState: StatusState.loading));
    final BaseResult<String> result = await _settingsRepository.changeLanguage(
      context,
      languageCode,
    );

    final SettingsState newState = result.when(
      result: (String data) => state.copyWith(
        statusState: data.isNotEmpty ? StatusState.success : StatusState.idle,
        message: data,
      ),
      error: (String message) =>
          state.copyWith(statusState: StatusState.failure, message: message),
    );
    emit(newState);
  }
}
