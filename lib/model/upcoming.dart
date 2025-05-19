// ignore_for_file: always_specify_types

import 'package:dart_mappable/dart_mappable.dart';
import 'package:drift/drift.dart';

import '../data/local/app_database.dart';
import 'date_range.dart';
import 'drama.dart';

part 'upcoming.mapper.dart';

@MappableClass()
class Upcoming with UpcomingMappable {
  String id;
  String title;
  String? imageUrl;
  String link;
  String network;
  String week;
  DateRange? weekRange;

  Upcoming({
    this.id = '',
    this.title = '',
    this.imageUrl,
    this.link = '',
    this.network = '',
    this.week = '',
    this.weekRange,
  });

  UpcomingCompanion get toUpcomingTable => UpcomingCompanion.insert(
    id: id,
    title: title,
    startDate: Value.absentIfNull(weekRange?.start),
    endDate: Value.absentIfNull(weekRange?.end),
    image: Value.absentIfNull(imageUrl),
  );

  Drama toDrama() =>
      Drama(id: id, title: title, imageUrl: imageUrl ?? '', url: link);
}
