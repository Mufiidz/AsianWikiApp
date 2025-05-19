import 'package:bloc/bloc.dart';
import 'package:dart_mappable/dart_mappable.dart';
import 'package:injectable/injectable.dart';

import '../../../data/base_result.dart';
import '../../../data/base_state.dart';
import '../../../model/detail_drama.dart';
import '../../../repository/detail_repository.dart';

part 'detail_drama_state.dart';
part 'detail_drama_cubit.mapper.dart';

@injectable
class DetailDramaCubit extends Cubit<DetailDramaState> {
  final DetailRepository _detailRepository;
  DetailDramaCubit(this._detailRepository) : super(DetailDramaState());

  void getDetail(String id) async {
    if (id.isEmpty) return;
    emit(state.copyWith(statusState: StatusState.loading));
    final BaseResult<DetailDrama> result = await _detailRepository
        .getDetailShow(id);

    final DetailDramaState newState = result.when(
      result:
          (DetailDrama data) =>
              state.copyWith(drama: data, statusState: StatusState.idle),
      error:
          (String message) => state.copyWith(
            statusState: StatusState.failure,
            message: message,
          ),
    );

    emit(newState);
  }
}
