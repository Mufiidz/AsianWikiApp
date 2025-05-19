import 'package:dart_mappable/dart_mappable.dart';

part 'date_range.mapper.dart';

@MappableClass()
class DateRange with DateRangeMappable {
  DateTime? start;
  DateTime? end;

  DateRange({this.start, this.end});
}