import 'package:dart_mappable/dart_mappable.dart';

part 'person_show.mapper.dart';

@MappableClass()
class PersonShow with PersonShowMappable {
  @MappableField(key: 'section')
  final String titleSection;
  final List<ItemPersonShow> items;

  const PersonShow({
    this.titleSection = '',
    this.items = const <ItemPersonShow>[],
  });
}

@MappableClass()
class ItemPersonShow with ItemPersonShowMappable {
  final String id;
  final String title;
  final String? altTitle;
  final String? network;
  final int year;
  final String cast;

  const ItemPersonShow({
    this.id = '',
    this.title = '',
    this.altTitle,
    this.network,
    this.year = 0,
    this.cast = '',
  });
}
