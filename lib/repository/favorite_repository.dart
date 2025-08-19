// ignore_for_file: always_specify_types

import 'package:injectable/injectable.dart';

import '../data/base_result.dart';
import '../data/local/dao/favorite_dao.dart';
import '../model/favorite.dart';
import '../res/constants/constants.dart' as constants;
import '../utils/logger.dart';

abstract class FavoriteRepository {
  Future<bool?> isFavorite(String id);
  Future<BaseResult<Favorite>> addFavorite(Favorite favorite);
  Future<BaseResult<List<Favorite>>> getFavorites({int? page});
  Future<BaseResult<List<Favorite>>> getFavoriteDramas({int? page, int? size});
  Future<BaseResult<List<Favorite>>> getFavoriteMovies({int? page, int? size});
  Future<BaseResult<List<Favorite>>> getFavoriteActress({int? page, int? size});
  Future<BaseResult<String>> deleteFavorite(String id);
  Future<BaseResult<String>> deleteAllFavorites();
}

@Injectable(as: FavoriteRepository)
class FavoriteRepositoryImpl implements FavoriteRepository {
  final FavoriteDao _favoriteDao;

  FavoriteRepositoryImpl(this._favoriteDao);

  @override
  Future<bool?> isFavorite(String id) async {
    try {
      final isFavorite = await _favoriteDao.isFavorite(id);

      return isFavorite;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<BaseResult<Favorite>> addFavorite(Favorite favorite) async {
    try {
      return DataResult(await _favoriteDao.addFavorite(favorite));
    } catch (e) {
      return ErrorResult(e.toString());
    }
  }

  @override
  Future<BaseResult<String>> deleteAllFavorites() async {
    try {
      final deletedItem = await _favoriteDao.deleteAllFavorites();

      logger.d(deletedItem);
      final message = deletedItem > 0
          ? 'Deleted $deletedItem favorite(s)'
          : 'No favorite(s) deleted';

      return DataResult(message);
    } catch (e) {
      logger.e(e);
      return ErrorResult(e.toString());
    }
  }

  @override
  Future<BaseResult<String>> deleteFavorite(String id) async {
    try {
      final deletedFavorite = await _favoriteDao.deleteFavorite(id);

      logger.d(deletedFavorite);
      final String message = deletedFavorite != null
          ? '${deletedFavorite.title} has been deleted'
          : 'No favorite deleted';
      return DataResult(message);
    } catch (e) {
      return ErrorResult(e.toString());
    }
  }

  @override
  Future<BaseResult<List<Favorite>>> getFavoriteActress({
    int? page,
    int? size,
  }) async {
    try {
      final List<Favorite> favorites = await _favoriteDao.getFavorites(
        type: constants.actress,
        page: page,
        size: size,
      );
      return DataResult(favorites);
    } catch (e) {
      return ErrorResult(e.toString());
    }
  }

  @override
  Future<BaseResult<List<Favorite>>> getFavoriteDramas({
    int? page,
    int? size,
  }) async {
    try {
      final List<Favorite> favorites = await _favoriteDao.getFavorites(
        type: constants.drama,
        page: page,
        size: size,
      );
      return DataResult(favorites);
    } catch (e) {
      return ErrorResult(e.toString());
    }
  }

  @override
  Future<BaseResult<List<Favorite>>> getFavoriteMovies({
    int? page,
    int? size,
  }) async {
    try {
      final List<Favorite> favorites = await _favoriteDao.getFavorites(
        type: constants.movie,
        page: page,
        size: size,
      );
      return DataResult(favorites);
    } catch (e) {
      return ErrorResult(e.toString());
    }
  }

  @override
  Future<BaseResult<List<Favorite>>> getFavorites({int? page}) async {
    try {
      final List<Favorite> favorites = await _favoriteDao.getFavorites(
        page: page,
      );
      return DataResult(favorites);
    } catch (e) {
      return ErrorResult(e.toString());
    }
  }
}
