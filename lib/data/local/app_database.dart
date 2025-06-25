// import 'dart:io';

import 'package:drift/drift.dart';
// import 'package:drift/native.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:injectable/injectable.dart';
// import 'package:path/path.dart' as p;
// import 'package:path_provider/path_provider.dart';
// import 'package:sqlite3/sqlite3.dart';
// import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';

import '../../config/env.dart';
import 'app_database.steps.dart';
import 'tables/favorite_table.dart';
import 'tables/upcoming.dart';

part 'app_database.g.dart';

@lazySingleton
@DriftDatabase(tables: <Type>[Upcoming, FavoriteTable])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 2;

  static QueryExecutor _openConnection() =>
      driftDatabase(name: Env.dbName, native: const DriftNativeOptions());

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (Migrator m) => m.createAll(),
    onUpgrade: stepByStep(
      from1To2: (Migrator m, Schema2 schema) async =>
          await m.createTable(schema.favorite),
    ),
  );
}

// LazyDatabase _openConnection() => LazyDatabase(() async {
//   final Directory dbFolder = await getApplicationDocumentsDirectory();
//   final File file = File(p.join(dbFolder.path, 'asianwiki.db'));

//   if (Platform.isAndroid) {
//     await applyWorkaroundToOpenSqlite3OnOldAndroidVersions();
//   }

//   final String cacheBase = (await getTemporaryDirectory()).path;

//   sqlite3.tempDirectory = cacheBase;
//   return NativeDatabase.createBackgroundConnection(file, logStatements: true);
// });
