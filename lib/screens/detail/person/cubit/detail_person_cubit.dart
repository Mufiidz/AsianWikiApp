import 'package:bloc/bloc.dart';
import 'package:dart_mappable/dart_mappable.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/base_result.dart';
import '../../../../data/base_state.dart';
import '../../../../model/detail_person.dart';
import '../../../../model/favorite.dart';
import '../../../../repository/detail_repository.dart';
import '../../../../repository/favorite_repository.dart';

part 'detail_person_state.dart';
part 'detail_person_cubit.mapper.dart';

@injectable
class DetailPersonCubit extends Cubit<DetailPersonState> {
  final DetailRepository _detailRepository;
  final FavoriteRepository _favoriteRepository;
  DetailPersonCubit(this._detailRepository, this._favoriteRepository)
    : super(DetailPersonState());

  void initial(String id, String? langCode) async {
    if (id.isEmpty) return;

    emit(state.copyWith(statusState: StatusState.loading));

    DetailPersonState newState;

    final bool? isFavorite = await _favoriteRepository.isFavorite(id);
    newState = state.copyWith(isFavorite: isFavorite);

    final BaseResult<DetailPerson> result = await _detailRepository
        .getDetailPerson(id, langCode);

    newState = result.when(
      result: (DetailPerson data) =>
          newState.copyWith(person: data, statusState: StatusState.idle),
      error: (String message) =>
          newState.copyWith(statusState: StatusState.failure, message: message),
    );

    emit(newState);
  }

  void toggleFavorite() async {
    bool? isFavorite = state.isFavorite;
    if (isFavorite == null) return null;

    final DetailPersonState newState;
    if (!isFavorite) {
      newState = await _addFavorite();
    } else {
      newState = await _unFavorite();
    }
    emit(newState);
  }

  Future<DetailPersonState> _addFavorite() async {
    final BaseResult<Favorite> result = await _favoriteRepository.addFavorite(
      state.person.toFavorite,
    );

    final DetailPersonState newState = result.when(
      result: (Favorite data) => state.copyWith(isFavorite: true),
      error: (String message) => state.copyWith(message: message),
    );
    return newState;
  }

  Future<DetailPersonState> _unFavorite() async {
    final BaseResult<String> result = await _favoriteRepository.deleteFavorite(
      state.person.id,
    );

    final DetailPersonState newState = result.when(
      result: (String data) => state.copyWith(isFavorite: false, message: data),
      error: (String message) => state.copyWith(message: message),
    );
    return newState;
  }
}
