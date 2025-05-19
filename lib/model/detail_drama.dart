import 'package:dart_mappable/dart_mappable.dart';

import 'date_range.dart';
import 'simple_data.dart';
import 'synopsis.dart';

part 'detail_drama.mapper.dart';

@MappableClass()
class DetailDrama with DetailDramaMappable {
  String id;
  String title;
  String url;
  String imageUrl;
  int rating;
  int vote;
  String alternativeTitle;
  String latinTitle;
  String nativeTitle;
  String director;
  String writer;
  String releaseDate;
  String language;
  String country;
  ShowType? type;
  String notes;
  Synopsis synopsis;
  int episodes;
  DateRange? releaseDateRange;

  DetailDrama({
    this.id = '',
    this.title = '',
    this.url = '',
    this.imageUrl = '',
    this.rating = 0,
    this.vote = 0,
    this.alternativeTitle = '',
    this.latinTitle = '',
    this.nativeTitle = '',
    this.director = '',
    this.writer = '',
    this.releaseDate = '',
    this.language = '',
    this.country = '',
    this.type,
    this.notes = '',
    this.synopsis = const Synopsis(),
    this.episodes = 0,
    this.releaseDateRange,
  });

  List<SimpleData> getInfo() {
    final List<SimpleData> infos = <SimpleData>[
      SimpleData(title: 'Alternative Title', content: alternativeTitle),
      SimpleData(title: 'Latin Title', content: latinTitle),
      SimpleData(title: 'Native Title', content: nativeTitle),
      SimpleData(title: 'Writer', content: writer),
      SimpleData(title: 'Release Date', content: releaseDate),
      SimpleData(title: 'Language', content: language),
    ];

    if (episodes > 0) {
      infos.add(SimpleData(title: 'Episodes', content: '$episodes'));
    }

    if (type == null) return List<SimpleData>.empty();
    return infos;
  }
}

@MappableEnum()
enum ShowType {
  @MappableValue('Movie')
  movie,
  @MappableValue('Drama')
  drama,
}
