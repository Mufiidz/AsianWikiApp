import 'package:dart_mappable/dart_mappable.dart';
import 'package:easy_localization/easy_localization.dart';

import '../res/locale_keys.g.dart';
import 'date_range.dart';
import 'simple_data.dart';
import 'synopsis.dart';

part 'detail_show.mapper.dart';

@MappableClass()
class DetailShow with DetailShowMappable {
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

  DetailShow({
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
      SimpleData(
        title: LocaleKeys.alternative_title.tr(),
        content: alternativeTitle,
      ),
      SimpleData(title: LocaleKeys.latin_title.tr(), content: latinTitle),
      SimpleData(title: LocaleKeys.native_title.tr(), content: nativeTitle),
      SimpleData(title: LocaleKeys.writer.tr(), content: writer),
      SimpleData(title: LocaleKeys.release_date.tr(), content: releaseDate),
      SimpleData(title: LocaleKeys.language.tr(), content: language),
    ];

    if (episodes > 0) {
      infos.add(
        SimpleData(title: LocaleKeys.episodes.tr(), content: '$episodes'),
      );
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
