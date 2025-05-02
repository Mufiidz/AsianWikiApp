import 'package:dart_mappable/dart_mappable.dart';

part 'drama.mapper.dart';

@MappableClass()
class Drama with DramaMappable {
  final String id;
  final String title;
  final String url;
  final String imageUrl;

  Drama({this.id = '', this.title = '', this.url = '', this.imageUrl = ''});

  bool get isEmpty => id.isEmpty && title.isEmpty && imageUrl.isEmpty;
}
