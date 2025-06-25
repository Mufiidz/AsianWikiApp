import 'package:drift/drift.dart';

import '../../../model/favorite.dart';
import '../app_database.dart';
import 'base_table.dart';

class FavoriteTable extends Table with BaseTable {
  TextColumn get title => text()();
  TextColumn get image => text()();
  TextColumn get type => text()();

  @override
  String? get tableName => 'favorite';
}

extension FavoriteTableDataExt on FavoriteTableData {
  Favorite get toFavorite => Favorite(
    id: id,
    title: title,
    imageUrl: image,
    type: type,
    createdAt: createdAt,
  );
}
