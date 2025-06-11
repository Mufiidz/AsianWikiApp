import 'package:bloc/bloc.dart';
import 'package:dart_mappable/dart_mappable.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/base_result.dart';
import '../../../../data/base_state.dart';
import '../../../../model/detail_person.dart';
import '../../../../repository/detail_repository.dart';

part 'detail_person_state.dart';
part 'detail_person_cubit.mapper.dart';

@injectable
class DetailPersonCubit extends Cubit<DetailPersonState> {
  final DetailRepository _detailRepository;
  DetailPersonCubit(this._detailRepository) : super(DetailPersonState());

  void initial(String id, String? langCode) async {
    if (id.isEmpty) return;

    emit(state.copyWith(statusState: StatusState.loading));

    final BaseResult<DetailPerson> result = await _detailRepository
        .getDetailPerson(id, langCode);

    final DetailPersonState newState = result.when(
      result: (DetailPerson data) =>
          state.copyWith(person: data, statusState: StatusState.idle),
      error: (String message) =>
          state.copyWith(statusState: StatusState.failure, message: message),
    );

    emit(newState);
  }
}
