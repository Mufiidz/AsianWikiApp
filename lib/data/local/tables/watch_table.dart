import 'package:drift/drift.dart';

import '../../../model/detail_show.dart';
import '../../../model/watch.dart';
import '../../../utils/export_utils.dart';
import '../app_database.dart';
import 'base_table.dart';

class WatchTable extends Table with BaseTable {
  TextColumn get title => text()();
  TextColumn get image => text()();
  TextColumn get type => text().nullable()();
  BoolColumn get isWatched =>
      boolean().withDefault(const Constant<bool>(false))();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

extension WatchTableExt on WatchTableData {
  Watch get toWatch => Watch(
    id: id,
    title: title,
    image: image,
    type: ShowTypeMapper.ensureInitialized().decode(type.toTitleCase()),
    isWatched: isWatched,
    updatedAt: updatedAt,
    createdAt: createdAt,
  );
}
