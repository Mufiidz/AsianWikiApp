import 'package:dart_mappable/dart_mappable.dart';
import 'package:drift/drift.dart';

import '../data/local/app_database.dart';
import 'detail_show.dart';

part 'watch.mapper.dart';

@MappableClass()
class Watch with WatchMappable {
  final String id;
  final String title;
  final String image;
  final ShowType? type;
  final bool isWatched;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Watch({
    this.id = '',
    this.title = '',
    this.image = '',
    this.type,
    this.isWatched = false,
    this.createdAt,
    this.updatedAt,
  });

  WatchTableCompanion get toWatchTable => WatchTableCompanion(
    id: Value<String>(id),
    title: Value<String>(title),
    image: Value<String>(image),
    type: Value<String>.absentIfNull(type?.name),
    isWatched: Value<bool>(isWatched),
    updatedAt: Value<DateTime>.absentIfNull(updatedAt),
  );
}
