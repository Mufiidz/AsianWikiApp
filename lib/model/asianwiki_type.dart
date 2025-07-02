import 'package:dart_mappable/dart_mappable.dart';

part 'asianwiki_type.mapper.dart';

@MappableEnum(defaultValue: AsianwikiType.unknown)
enum AsianwikiType { actress, drama, movie, unknown }
