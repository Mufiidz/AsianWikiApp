import 'package:drift/drift.dart';

import '../../../model/asianwiki_type.dart';
import '../../../model/upcoming_reminder.dart';
import '../app_database.dart';
import 'base_table.dart';

class UpcomingReminderTable extends Table with BaseTable {
  IntColumn get notifId => integer()();
  TextColumn get title => text()();
  TextColumn get type => text()();
  DateTimeColumn get reminderOn => dateTime()();
}

extension UpcomingReminderTableExt on UpcomingReminderTableData {
  UpcomingReminder get toUpcomingReminder => UpcomingReminder(
    id: notifId,
    showId: id,
    title: title,
    type: AsianwikiTypeMapper.ensureInitialized().decode(type),
    reminderOn: reminderOn,
    createdAt: createdAt,
  );
}
