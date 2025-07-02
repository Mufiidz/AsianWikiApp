import 'package:bloc/bloc.dart';
import 'package:dart_mappable/dart_mappable.dart';
import 'package:injectable/injectable.dart';

import '../../../data/base_result.dart';
import '../../../data/base_state.dart';
import '../../../model/asianwiki_type.dart';
import '../../../repository/home_repository.dart';

part 'deeplink_state.dart';
part 'deeplink_cubit.mapper.dart';

@injectable
class DeeplinkCubit extends Cubit<DeeplinkState> {
  final HomeRepository _homeRepository;
  DeeplinkCubit(this._homeRepository) : super(DeeplinkState());

  Future<void> getType(String id) async {
    emit(state.copyWith(statusState: StatusState.loading));
    final BaseResult<AsianwikiType> result = await _homeRepository.deeplink(id);
    final DeeplinkState newState = result.when(
      result: (AsianwikiType data) =>
          state.copyWith(statusState: StatusState.success, type: data),
      error: (String message) =>
          state.copyWith(statusState: StatusState.failure, message: message),
    );
    emit(newState);
  }
}
