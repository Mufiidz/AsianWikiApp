import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:share_plus/share_plus.dart';

import '../config/env.dart';
import '../data/base_result.dart';
import '../data/network/api_services.dart';
import '../data/network/cast_response.dart';
import '../di/injection.dart';
import '../model/asianwiki_type.dart';
import '../model/cast_show.dart';
import '../model/detail_person.dart';
import '../model/detail_show.dart';
import '../model/person_show.dart';
import '../utils/export_utils.dart';

abstract class DetailRepository {
  Future<BaseResult<DetailShow>> getDetailShow(String id, String? languageCode);
  Future<BaseResult<List<CastResponse>>> getCasts(String id);
  List<CastShow> searchCast(String query, List<CastResponse> castsResponses);
  Future<BaseResult<DetailPerson>> getDetailPerson(
    String id,
    String? languageCode,
  );
  List<ItemPersonShow> searchPersonShow(
    String query,
    List<PersonShow> personShows,
  );
  Future<BaseResult<String>> share({
    String id,
    String url,
    String title,
    AsianwikiType type,
  });
}

@Injectable(as: DetailRepository)
class DetailRepositoryImpl implements DetailRepository {
  final ApiServices _apiServices;

  DetailRepositoryImpl(this._apiServices);

  @override
  Future<BaseResult<DetailShow>> getDetailShow(
    String id,
    String? languageCode,
  ) => _apiServices.show(id, languageCode).awaitResponse;

  @override
  Future<BaseResult<List<CastResponse>>> getCasts(String id) =>
      _apiServices.casts(id).awaitResponse;

  @override
  List<CastShow> searchCast(String query, List<CastResponse> castsResponses) {
    final List<CastShow> defaultCasts = castsResponses
        .expand((CastResponse castResponse) => castResponse.casts)
        .toList();
    final List<String> titles = castsResponses
        .map((CastResponse castResponse) => castResponse.title.toLowerCase())
        .toList();

    if (query.isEmpty) return defaultCasts;

    if (titles.contains(query.toLowerCase())) {
      return castsResponses
          .where(
            (CastResponse castResponse) =>
                castResponse.title.toLowerCase() == query.toLowerCase(),
          )
          .first
          .casts;
    }

    return defaultCasts.where((CastShow castShow) {
      final CastShow(:String name, :String? cast) = castShow;
      return cast != null &&
          (name.toLowerCase().contains(query.toLowerCase()) ||
              cast.toLowerCase().contains(query.toLowerCase()));
    }).toList();
  }

  @override
  Future<BaseResult<DetailPerson>> getDetailPerson(
    String id,
    String? languageCode,
  ) => _apiServices.person(id, languageCode).awaitResponse;

  @override
  List<ItemPersonShow> searchPersonShow(
    String query,
    List<PersonShow> personShows,
  ) {
    final List<ItemPersonShow> defaultPersonShows = personShows
        .expand((PersonShow personShow) => personShow.items)
        .toList();

    final List<String> titles = personShows
        .map((PersonShow personShow) => personShow.titleSection.toLowerCase())
        .toList();

    if (query.isEmpty) return defaultPersonShows;

    if (titles.contains(query.toLowerCase())) {
      return personShows
          .where(
            (PersonShow personShow) =>
                personShow.titleSection.toLowerCase() == query.toLowerCase(),
          )
          .first
          .items;
    }

    return defaultPersonShows
        .where(
          (ItemPersonShow show) =>
              show.title.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();
  }

  @override
  Future<BaseResult<String>> share({
    String id = '',
    String url = '',
    String title = '',
    AsianwikiType type = AsianwikiType.unknown,
  }) async {
    try {
      String baseUrl;

      if (Platform.isAndroid) {
        baseUrl = Env.baseUrlAndroid;
      } else if (Platform.isIOS) {
        baseUrl = Env.baseUrlIos;
      } else {
        baseUrl = Env.asianwikiUrl;
      }
      // TODO : For example purpose, change this content
      final String content =
          "Lihat ini deh :${'\n\n'}*[${type.name.toTitleCase()}] $title*${'\n\n'}$baseUrl/deeplink/$id";
      final ShareParams params = ShareParams(
        text: content,
        uri: Uri.parse(url),
      );

      final ShareResult result = await getIt<SharePlus>().share(params);

      return switch (result.status) {
        ShareResultStatus.success => DataResult<String>('Success Share'),
        _ => ErrorResult<String>('Failed Share'),
      };
    } catch (e) {
      logger.e(e, tag: 'shareShow');
      return ErrorResult<String>(e.toString());
    }
  }
}
