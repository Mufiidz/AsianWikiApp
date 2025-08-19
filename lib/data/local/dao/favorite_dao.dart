import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

import '../../../model/favorite.dart';
import '../../../utils/logger.dart';
import '../app_database.dart';
import '../tables/favorite_table.dart';

part 'favorite_dao.g.dart';

abstract class FavoriteDao {
  Future<Favorite> addFavorite(Favorite favorite);
  Future<bool> isFavorite(String id);
  Future<List<Favorite>> getFavorites({String? type, int? size, int? page});
  Future<Favorite?> deleteFavorite(String id);
  Future<int> deleteAllFavorites();
}

@Injectable(as: FavoriteDao)
@DriftAccessor(tables: <Type>[FavoriteTable])
class FavoriteDaoImpl extends DatabaseAccessor<AppDatabase>
    with _$FavoriteDaoImplMixin
    implements FavoriteDao {
  FavoriteDaoImpl(super.db);

  @override
  Future<Favorite> addFavorite(Favorite favorite) async {
    final FavoriteTableData savedFavorite = await into(favoriteTable)
        .insertReturning(
          favorite.toFavoriteTable,
          mode: InsertMode.insertOrReplace,
        );
    return savedFavorite.toFavorite;
  }

  @override
  Future<Favorite?> deleteFavorite(String id) async {
    final List<FavoriteTableData> favorites = await (delete(
      favoriteTable,
    )..where(($FavoriteTableTable tbl) => tbl.id.equals(id))).goAndReturn();

    logger.d(favorites.length);

    if (favorites.isEmpty) return null;
    return favorites.first.toFavorite;
  }

  @override
  Future<List<Favorite>> getFavorites({
    String? type,
    int? size,
    int? page,
  }) async {
    final int newPage = page ?? 1;
    final int newSize = size ?? 5;
    final SimpleSelectStatement<$FavoriteTableTable, FavoriteTableData> query =
        select(favoriteTable);
    if (type != null) {
      query.where(
        ($FavoriteTableTable tbl) =>
            tbl.type.lower().equals(type.toLowerCase()),
      );
    }
    query
      ..limit(newSize, offset: (newPage - 1) * newSize)
      ..orderBy(<OrderClauseGenerator<$FavoriteTableTable>>[
        ($FavoriteTableTable tbl) =>
            OrderingTerm(expression: tbl.createdAt, mode: OrderingMode.desc),
      ]);

    final List<Favorite> favorites = (await query.get())
        .map((FavoriteTableData favorite) => favorite.toFavorite)
        .toList();
    return favorites;
  }

  @override
  Future<bool> isFavorite(String id) async {
    final FavoriteTableData? favorite =
        await (select(favoriteTable)..where(
              ($FavoriteTableTable table) => table.id.equalsNullable(id),
            ))
            .getSingleOrNull();
    return favorite != null;
  }

  @override
  Future<int> deleteAllFavorites() async => (delete(favoriteTable)).go();
}
