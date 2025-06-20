import 'package:dart_mappable/dart_mappable.dart';

part 'show.mapper.dart';

@MappableClass()
class Show with ShowMappable {
  final String id;
  final String title;
  final String url;
  final String imageUrl;
  final String? type;

  Show({
    this.id = '',
    this.title = '',
    this.url = '',
    this.imageUrl = '',
    this.type,
  });

  bool get isEmpty => id.isEmpty && title.isEmpty && imageUrl.isEmpty;
}
