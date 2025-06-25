import 'package:dart_mappable/dart_mappable.dart';

import '../data/local/app_database.dart';
import 'person.dart';

part 'favorite.mapper.dart';

@MappableClass()
class Favorite with FavoriteMappable {
  final String id;
  final String title;
  final String imageUrl;
  final String type;
  final DateTime? createdAt;

  const Favorite({
    this.id = '',
    this.title = '',
    this.imageUrl = '',
    this.type = '',
    this.createdAt,
  });

  FavoriteTableCompanion get toFavoriteTable => FavoriteTableCompanion.insert(
    id: id,
    title: title,
    image: imageUrl,
    type: type,
  );

  Person get toPerson => Person(id: id, name: title, imageUrl: imageUrl);
}
