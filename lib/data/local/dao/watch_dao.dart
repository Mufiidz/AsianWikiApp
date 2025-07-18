import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

import '../../../model/watch.dart';
import '../app_database.dart';
import '../tables/watch_table.dart';

part 'watch_dao.g.dart';

abstract class WatchDao {
  Future<Watch> addWatchList(Watch watch);
  Future<List<Watch>> getWatchList();
  Future<void> deleteWatchList(String showId);
  Future<void> deleteAllWatchList();
  // Future<void> updateWatchList(Watch watch);
  Future<bool> isWatchListExist(String showId);
}

@Injectable(as: WatchDao)
@DriftAccessor(tables: <Type>[WatchTable])
class WatchDaoImpl extends DatabaseAccessor<AppDatabase>
    with _$WatchDaoImplMixin
    implements WatchDao {
  WatchDaoImpl(super.db);

  @override
  Future<Watch> addWatchList(Watch watch) async {
    try {
      final WatchTableData savedWatch = await into(
        watchTable,
      ).insertReturning(watch.toWatchTable, mode: InsertMode.insertOrReplace);
      return savedWatch.toWatch;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteAllWatchList() {
    try {
      return delete(watchTable).go();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteWatchList(String showId) {
    try {
      return (delete(
        watchTable,
      )..where(($WatchTableTable tbl) => tbl.id.equals(showId))).go();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Watch>> getWatchList() async {
    try {
      final List<WatchTableData> watchList = await select(watchTable).get();
      return watchList.map((WatchTableData e) => e.toWatch).toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> isWatchListExist(String showId) async {
    try {
      final WatchTableData? watch =
          await (select(watchTable)
                ..where(($WatchTableTable tbl) => tbl.id.equals(showId)))
              .getSingleOrNull();
      return watch != null;
    } catch (e) {
      rethrow;
    }
  }
}
