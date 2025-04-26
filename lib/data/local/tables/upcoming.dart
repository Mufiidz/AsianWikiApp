import 'package:drift/drift.dart';

class Upcoming extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  TextColumn get image => text().nullable()();
  DateTimeColumn get startDate => dateTime().nullable()();
  DateTimeColumn get endDate => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDate)();

  @override
  Set<Column<Object>>? get primaryKey => <Column<Object>>{id};
}
