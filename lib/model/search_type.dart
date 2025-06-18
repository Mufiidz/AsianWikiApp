import 'package:dart_mappable/dart_mappable.dart';

part 'search_type.mapper.dart';

@MappableEnum(caseStyle: CaseStyle(head: TextTransform.capitalCase))
enum SearchType { all, drama, movie, name }
