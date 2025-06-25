import 'package:drift/drift.dart';

mixin BaseTable on Table {
  TextColumn get id => text()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column<Object>>? get primaryKey => <Column<Object>>{id};
}
