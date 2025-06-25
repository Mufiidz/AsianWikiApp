import 'package:bloc/bloc.dart';
import 'package:dart_mappable/dart_mappable.dart';
import 'package:injectable/injectable.dart';

import '../../../data/base_result.dart';
import '../../../data/base_state.dart';
import '../../../model/favorite.dart';
import '../../../repository/favorite_repository.dart';
import '../../../utils/export_utils.dart';

part 'favorites_state.dart';
part 'favorites_cubit.mapper.dart';

@injectable
class FavoritesCubit extends Cubit<FavoritesState> {
  final FavoriteRepository _favoriteRepository;
  FavoritesCubit(this._favoriteRepository) : super(FavoritesState());

  void getFavorites({int? page, FavoriteType? type}) async {
    emit(state.copyWith(statusState: StatusState.loading));

    logger.d('page: $page, type: $type');

    FavoritesState newState = state;

    if (type != null) {
      newState = newState.copyWith(selectedFavoriteType: type);
    }

    final BaseResult<List<Favorite>> result = switch (type) {
      FavoriteType.actress => await _favoriteRepository.getFavoriteActress(
        page: page,
      ),
      FavoriteType.drama => await _favoriteRepository.getFavoriteDramas(
        page: page,
      ),
      FavoriteType.movie => await _favoriteRepository.getFavoriteMovies(
        page: page,
      ),
      _ => await _favoriteRepository.getFavorites(page: page),
    };

    newState = result.when(
      result: (List<Favorite> data) {
        return newState.copyWith(
          favorites: data,
          statusState: StatusState.idle,
        );
      },
      error: (String message) =>
          newState.copyWith(message: message, statusState: StatusState.failure),
    );

    emit(newState);
  }
}
