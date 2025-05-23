import 'package:injectable/injectable.dart';

import '../data/base_result.dart';
import '../data/network/api_services.dart';
import '../data/network/cast_response.dart';
import '../model/cast_show.dart';
import '../model/detail_show.dart';
import '../utils/export_utils.dart';

abstract class DetailRepository {
  Future<BaseResult<DetailShow>> getDetailShow(String id, String? languageCode);
  Future<BaseResult<List<CastResponse>>> getCasts(String id);
  List<CastShow> searchCast(String query, List<CastResponse> castsResponses);
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
    final List<CastShow> defaultCasts =
        castsResponses
            .expand((CastResponse castResponse) => castResponse.casts)
            .toList();
    final List<String> titles =
        castsResponses
            .map(
              (CastResponse castResponse) => castResponse.title.toLowerCase(),
            )
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
}
