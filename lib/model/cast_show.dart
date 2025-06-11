import 'package:dart_mappable/dart_mappable.dart';

import 'person.dart';

part 'cast_show.mapper.dart';

@MappableClass()
class CastShow with CastShowMappable {
  String id;
  String name;
  String profileUrl;
  String? imageUrl;
  String? cast;

  CastShow({
    this.id = '',
    this.name = '',
    this.profileUrl = '',
    this.imageUrl,
    this.cast,
  });

  Person get toPerson =>
      Person(id: id, name: name, url: profileUrl, imageUrl: imageUrl ?? '');
}
