import 'package:dart_mappable/dart_mappable.dart';
import 'package:drift/drift.dart';

import '../data/local/app_database.dart';
import 'asianwiki_type.dart';

part 'upcoming_reminder.mapper.dart';

@MappableClass()
class UpcomingReminder with UpcomingReminderMappable {
  final int id;
  final String showId;
  final String title;
  final AsianwikiType type;
  final DateTime reminderOn;
  final DateTime? createdAt;

  const UpcomingReminder({
    required this.reminderOn,
    this.id = 0,
    this.showId = '',
    this.title = '',
    this.type = AsianwikiType.unknown,
    this.createdAt,
  });

  UpcomingReminderTableCompanion get toUpcomingReminderTable =>
      UpcomingReminderTableCompanion(
        id: Value<String>(showId),
        notifId: Value<int>(id),
        title: Value<String>(title),
        type: Value<String>(type.name),
        reminderOn: Value<DateTime>(reminderOn),
      );
}
