import 'package:bloc/bloc.dart';
import 'package:dart_mappable/dart_mappable.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/base_result.dart';
import '../../../../data/base_state.dart';
import '../../../../data/network/cast_response.dart';
import '../../../../model/detail_show.dart';
import '../../../../repository/detail_repository.dart';
import '../../../../utils/logger.dart';

part 'detail_drama_state.dart';
part 'detail_drama_cubit.mapper.dart';

@injectable
class DetailDramaCubit extends Cubit<DetailDramaState> {
  final DetailRepository _detailRepository;
  final List<String> _errors = <String>[];
  bool isEmptyCasts = false;
  DetailDramaCubit(this._detailRepository) : super(DetailDramaState());

  void getAllDetail(String id, BuildContext context) async {
    if (id.isEmpty) return;
    emit(state.copyWith(statusState: StatusState.loading));
    _errors.clear();

    final List<Future<void>> actions = <Future<void>>[
      getDetail(id, context.locale.languageCode),
      getCasts(id),
    ];

    await Future.wait(actions);

    if (_errors.length == actions.length ||
        (_errors.length == 1 && isEmptyCasts)) {
      logger.e(_errors);
      emit(
        state.copyWith(statusState: StatusState.failure, message: _errors[0]),
      );
    }
  }

  Future<void> getDetail(String id, String? langCode) async {
    bool isError = false;
    final BaseResult<DetailShow> result = await _detailRepository.getDetailShow(
      id,
      langCode,
    );

    final DetailDramaState newState = result.when(
      result:
          (DetailShow data) =>
              state.copyWith(drama: data, statusState: StatusState.idle),
      error: (String message) {
        isError = true;
        return state.copyWith(statusState: StatusState.idle, message: message);
      },
    );

    if (isError) {
      _errors.add(newState.message);
      return;
    }
    emit(newState);
  }

  Future<void> getCasts(String id) async {
    bool isError = false;
    final BaseResult<List<CastResponse>> result = await _detailRepository
        .getCasts(id);

    final DetailDramaState newState = result.when(
      result: (List<CastResponse> data) {
        isEmptyCasts = data.isEmpty;
        return state.copyWith(casts: data, statusState: StatusState.idle);
      },
      error: (String message) {
        isError = true;
        return state.copyWith(statusState: StatusState.idle, message: message);
      },
    );

    if (isError) {
      _errors.add(newState.message);
      return;
    }
    emit(newState);
  }
}
