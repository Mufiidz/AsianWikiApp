// ignore_for_file: always_specify_types

import 'package:dart_mappable/dart_mappable.dart';
import 'package:drift/drift.dart';

import '../data/local/app_database.dart';
import '../utils/export_utils.dart';
import 'date_range.dart';
import 'show.dart';

part 'upcoming.mapper.dart';

@MappableClass()
class Upcoming with UpcomingMappable {
  String id;
  String title;
  String? imageUrl;
  String link;
  String network;
  String week;
  UpcomingType? type;
  DateRange? weekRange;

  Upcoming({
    this.id = '',
    this.title = '',
    this.imageUrl,
    this.link = '',
    this.network = '',
    this.week = '',
    this.weekRange,
    this.type,
  });

  UpcomingCompanion get toUpcomingTable => UpcomingCompanion.insert(
    id: id,
    title: title,
    type: Value.absentIfNull(type?.name.capitalizeFirst()),
    startDate: Value.absentIfNull(weekRange?.start),
    endDate: Value.absentIfNull(weekRange?.end),
    image: Value.absentIfNull(imageUrl),
  );

  Show get toDrama => Show(
    id: id,
    title: title,
    imageUrl: imageUrl ?? '',
    url: link,
    type: type?.name,
  );
}

@MappableEnum(caseStyle: CaseStyle.pascalCase)
enum UpcomingType { drama, movie }
