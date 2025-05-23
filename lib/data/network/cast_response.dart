import 'package:dart_mappable/dart_mappable.dart';

import '../../model/cast_show.dart';

part 'cast_response.mapper.dart';

@MappableClass()
class CastResponse with CastResponseMappable {
  final String title;
  final List<CastShow> casts;

  const CastResponse({this.title = '', this.casts = const <CastShow>[]});
}
