import 'package:dart_mappable/dart_mappable.dart';

part 'person.mapper.dart';

@MappableClass()
class Person with PersonMappable {
  final String id;
  final String name;
  final String url;
  final String imageUrl;

  Person({this.id = '', this.name = '', this.url = '', this.imageUrl = ''});
}
