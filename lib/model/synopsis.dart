import 'package:dart_mappable/dart_mappable.dart';

part 'synopsis.mapper.dart';

@MappableClass()
class Synopsis with SynopsisMappable {
  final String original;
  final String translated;
  final List<Link> links;

  const Synopsis({
    this.original = '',
    this.translated = '',
    this.links = const <Link>[],
  });
}

@MappableClass()
class Link with LinkMappable {
  final String url;
  final String name;

  Link({this.name = '', this.url = ''});
}
