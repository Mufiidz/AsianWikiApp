import 'package:dart_mappable/dart_mappable.dart';

import 'synopsis.dart';

part 'detail_drama.mapper.dart';

@MappableClass()
class DetailDrama with DetailDramaMappable {
  final String id;
  final String title;
  final String url;
  final String imageUrl;
  final int rating;
  final int vote;
  final String drama;
  final String revisedRomanization;
  final String hangul;
  final String director;
  final String writer;
  final String network;
  final int episodes;
  final String releaseDate;
  final String runtime;
  final String language;
  final String country;
  final Synopsis synopsis;

  DetailDrama({
    this.id = '',
    this.title = '',
    this.url = '',
    this.imageUrl = '',
    this.rating = 0,
    this.vote = 0,
    this.drama = '',
    this.revisedRomanization = '',
    this.hangul = '',
    this.director = '',
    this.writer = '',
    this.network = '',
    this.episodes = 0,
    this.releaseDate = '',
    this.runtime = '',
    this.language = '',
    this.country = '',
    this.synopsis = const Synopsis(),
  });

}
