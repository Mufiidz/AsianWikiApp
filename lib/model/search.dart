import 'package:dart_mappable/dart_mappable.dart';

import 'search_type.dart';
import 'show.dart';

part 'search.mapper.dart';

@MappableClass()
class Search with SearchMappable {
  final String id;
  final String title;
  final SearchType type;
  final String url;
  final String? imageUrl;

  const Search({
    this.id = '',
    this.title = '',
    this.type = SearchType.all,
    this.url = '',
    this.imageUrl,
  });

  Show get toShow =>
      Show(id: id, title: title, imageUrl: imageUrl ?? '', url: url);
}
