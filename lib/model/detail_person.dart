import 'package:dart_mappable/dart_mappable.dart';

import '../res/export_res.dart';
import '../utils/export_utils.dart';
import 'favorite.dart';
import 'person_show.dart';
import 'simple_data.dart';
import 'sosmed.dart';

part 'detail_person.mapper.dart';

@MappableClass()
class DetailPerson with DetailPersonMappable {
  final String id;
  final String title;
  final String imageUrl;
  final String name;
  final String birthName;
  final DateTime? born;
  final String birthplace;
  final String? facebook;
  final String? instagram;
  final String? tiktok;
  final String? x;
  final String nativeName;
  final String type;
  final String bloodType;
  final int rating;
  final int votes;
  final String notes;
  final String? university;
  final int height;
  final int age;
  final List<PersonShow> shows;
  final List<String>? biographies;

  const DetailPerson({
    this.id = '',
    this.title = '',
    this.imageUrl = '',
    this.name = '',
    this.birthName = '',
    this.born,
    this.birthplace = '',
    this.facebook,
    this.instagram,
    this.tiktok,
    this.x,
    this.nativeName = '',
    this.type = '',
    this.rating = 0,
    this.votes = 0,
    this.notes = '',
    this.bloodType = '',
    this.height = 0,
    this.shows = const <PersonShow>[],
    this.biographies,
    this.university,
    this.age = 0,
  });

  List<Sosmed> get sosmed =>
      <SimpleData>[
            SimpleData.nullableContent(
              title: 'Facebook',
              content: facebook,
              defaultValue: '',
            ),
            SimpleData.nullableContent(
              title: 'Instagram',
              content: instagram,
              defaultValue: '',
            ),
            SimpleData.nullableContent(
              title: 'Tiktok',
              content: tiktok,
              defaultValue: '',
            ),
            SimpleData.nullableContent(
              title: 'X',
              content: x,
              defaultValue: '',
            ),
          ]
          .where((SimpleData sosmed) => sosmed.content.isNotEmpty)
          .map(
            (SimpleData sosmed) =>
                Sosmed(title: sosmed.title, username: sosmed.content),
          )
          .toList();

  List<SimpleData> get info => <SimpleData>[
    SimpleData(
      title: LocaleKeys.rating.tr(),
      content: '$rating% ($votes vote)',
    ),
    SimpleData.nullableContent(
      title: LocaleKeys.born.tr(),
      content: born?.toIso8601String().toDateFormat(),
    ),
    SimpleData(title: LocaleKeys.birthplace.tr(), content: birthplace),
    SimpleData.nullableContent(
      title: LocaleKeys.native_name.tr(),
      content: nativeName,
    ),
    SimpleData.nullableContent(
      title: LocaleKeys.birthname.tr(),
      content: birthName,
    ),
    SimpleData.nullableContent(
      title: LocaleKeys.blood_type.tr(),
      content: bloodType,
    ),
    SimpleData.nullableContent(
      title: LocaleKeys.age.tr(),
      content: age > 0 ? '$age' : '-',
    ),
    SimpleData(
      title: LocaleKeys.height.tr(),
      content: height > 0 ? '$height cm' : '-',
    ),
    SimpleData.nullableContent(
      title: LocaleKeys.university.tr(),
      content: university,
    ),
  ];

  Favorite get toFavorite =>
      Favorite(id: id, title: title, imageUrl: imageUrl, type: type);
}
