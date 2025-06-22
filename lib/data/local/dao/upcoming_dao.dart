// ignore_for_file: always_specify_types

import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

import '../../../model/date_range.dart';
import '../../../model/upcoming.dart';
import '../../../utils/export_utils.dart';
import '../app_database.dart';
import '../tables/upcoming.dart' as table;

part 'upcoming_dao.g.dart';

abstract class UpcomingDao {
  Future<void> addUpcomings(List<Upcoming> upcomings);
  Future<List<Upcoming>> getUpcomingsByMonth(int? month, {int? page = 1});
  Future<int> deleteAllUpcomings();
}

@Injectable(as: UpcomingDao)
@DriftAccessor(tables: <Type>[table.Upcoming])
class UpcomingDaoImpl extends DatabaseAccessor<AppDatabase>
    with _$UpcomingDaoImplMixin
    implements UpcomingDao {
  UpcomingDaoImpl(super.db);

  @override
  Future<void> addUpcomings(List<Upcoming> upcomings) async {
    final List<UpcomingCompanion> newUpcoming = upcomings
        .map((Upcoming e) => e.toUpcomingTable)
        .toList();
    return await batch(
      (Batch batch) => batch.insertAllOnConflictUpdate(upcoming, newUpcoming),
    );
  }

  @override
  Future<List<Upcoming>> getUpcomingsByMonth(
    int? month, {
    int? page = 1,
  }) async {
    final currentDatetime = DateTime.now();
    final currentMonth = month ?? currentDatetime.month;
    final queryDt = DateTime(currentDatetime.year, currentMonth);
    const int size = 5;
    final int currentPage = (page ?? 1) - 1;
    final upcomingDatas =
        await (select(upcoming)
              ..where(
                ($UpcomingTable tbl) =>
                    tbl.createdAt.year.equals(queryDt.year) &
                    tbl.createdAt.month.equals(queryDt.month),
              )
              ..limit(size, offset: currentPage * size))
            .get();

    final newUpcomings = upcomingDatas
        .map(
          (UpcomingData data) => Upcoming(
            id: data.id,
            title: data.title,
            imageUrl: data.image,
            type: UpcomingTypeMapper.ensureInitialized().decode(
              data.type?.capitalizeFirst(),
            ),
            weekRange: DateRange(start: data.startDate, end: data.endDate),
          ),
        )
        .toList();
    return newUpcomings;
  }

  @override
  Future<int> deleteAllUpcomings() => delete(upcoming).go();
}
