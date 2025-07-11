import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

import '../../../model/upcoming_reminder.dart';
import '../app_database.dart';
import '../tables/upcoming_reminder_table.dart';

part 'upcoming_reminder_dao.g.dart';

abstract class UpcomingReminderDao {
  Future<UpcomingReminder> addUpcomingReminder(
    UpcomingReminder upcomingReminder,
  );
  Future<bool> isUpcomingReminderExist(String showId);
  Future<List<UpcomingReminder>> getUpcomingReminders();
  Future<UpcomingReminder?> deleteUpcomingReminder(String showId);
}

@Injectable(as: UpcomingReminderDao)
@DriftAccessor(tables: <Type>[UpcomingReminderTable])
class UpcomingReminderDaoImpl extends DatabaseAccessor<AppDatabase>
    with _$UpcomingReminderDaoImplMixin
    implements UpcomingReminderDao {
  UpcomingReminderDaoImpl(super.db);

  @override
  Future<UpcomingReminder> addUpcomingReminder(
    UpcomingReminder upcomingReminder,
  ) async {
    try {
      final UpcomingReminderTableData savedUpcomingReminder =
          await into(upcomingReminderTable).insertReturning(
            upcomingReminder.toUpcomingReminderTable,
            mode: InsertMode.insertOrAbort,
          );
      return savedUpcomingReminder.toUpcomingReminder;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UpcomingReminder?> deleteUpcomingReminder(String showId) async {
    try {
      final List<UpcomingReminderTableData> upcomingReminders =
          await (delete(upcomingReminderTable)..where(
                ($UpcomingReminderTableTable tbl) => tbl.id.equals(showId),
              ))
              .goAndReturn();

      if (upcomingReminders.isEmpty) return null;
      return upcomingReminders.first.toUpcomingReminder;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> isUpcomingReminderExist(String showId) async {
    try {
      final UpcomingReminderTableData? upcomingReminder =
          await (select(upcomingReminderTable)..where(
                ($UpcomingReminderTableTable tbl) =>
                    tbl.id.equalsNullable(showId),
              ))
              .getSingleOrNull();
      return upcomingReminder != null;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<UpcomingReminder>> getUpcomingReminders() async {
    try {
      final List<UpcomingReminderTableData> upcomingReminders = await select(
        upcomingReminderTable,
      ).get();
      return upcomingReminders
          .map((UpcomingReminderTableData e) => e.toUpcomingReminder)
          .toList();
    } catch (e) {
      rethrow;
    }
  }
}
