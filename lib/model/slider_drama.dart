import 'package:dart_mappable/dart_mappable.dart';

part 'slider_drama.mapper.dart';

@MappableClass()
class SliderDrama with SliderDramaMappable {
  final String id;
  final String title;
  final String url;
  final String imageUrl;

  SliderDrama({
    this.id = '',
    this.title = '',
    this.url = '',
    this.imageUrl = '',
  });

  bool get isEmpty => id.isEmpty && title.isEmpty && imageUrl.isEmpty;
}
