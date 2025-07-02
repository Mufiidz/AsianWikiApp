import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/base_result.dart';
import '../data/local/dao/upcoming_dao.dart';
import '../data/network/api_services.dart';
import '../model/asianwiki_type.dart';
import '../model/show.dart';
import '../model/upcoming.dart';
import '../res/constants/sharedpref_keys.dart' as sharedpref_keys;
import '../utils/export_utils.dart';

abstract class HomeRepository {
  Future<BaseResult<List<Show>>> getSlider();
  Future<BaseResult<List<Upcoming>>> getUpcoming({int? month, int? page});
  Future<BaseResult<AsianwikiType>> deeplink(String id);
}

@Injectable(as: HomeRepository)
class HomeRepositoryImpl implements HomeRepository {
  final ApiServices _apiServices;
  final UpcomingDao _upcomingDao;
  final SharedPreferencesWithCache _sharedPreferencesWithCache;

  HomeRepositoryImpl(
    this._apiServices,
    this._upcomingDao,
    this._sharedPreferencesWithCache,
  );

  @override
  Future<BaseResult<List<Show>>> getSlider() =>
      _apiServices.slider().awaitResponse;

  @override
  Future<BaseResult<List<Upcoming>>> getUpcoming({
    int? month,
    int? page = 1,
  }) async {
    try {
      final int queryPage = page ?? 1;
      final int currentMonth = month ?? DateTime.now().month;

      final int? savedMonth = _sharedPreferencesWithCache.getInt(
        sharedpref_keys.lastMonthUpcoming,
      );
      final int? savedPage = _sharedPreferencesWithCache.getInt(
        sharedpref_keys.lastPageUpcoming,
      );

      if (savedMonth != null && currentMonth != savedMonth) {
        await _sharedPreferencesWithCache.remove(
          sharedpref_keys.lastPageUpcoming,
        );
      }

      List<Upcoming> upcomings = await _upcomingDao.getUpcomingsByMonth(
        currentMonth,
        page: queryPage,
      );

      if (upcomings.isNotEmpty) return DataResult<List<Upcoming>>(upcomings);

      if (savedPage != null && queryPage > savedPage) {
        return DataResult<List<Upcoming>>(<Upcoming>[]);
      }

      logger.d('remote upcomings');

      final BaseResult<List<Upcoming>> response = await _apiServices
          .allUpcoming(currentMonth, page: queryPage)
          .awaitResponse;

      if (response.isError) {
        throw response.onErrorResult;
      }

      upcomings = response.onDataResult;

      if (upcomings.isEmpty) {
        final int lastPage = queryPage > 1 ? queryPage - 1 : 1;
        await _sharedPreferencesWithCache.setInt(
          sharedpref_keys.lastPageUpcoming,
          lastPage,
        );
        await _sharedPreferencesWithCache.setInt(
          sharedpref_keys.lastMonthUpcoming,
          currentMonth,
        );
        return DataResult<List<Upcoming>>(upcomings);
      }

      await _upcomingDao.addUpcomings(upcomings);

      return DataResult<List<Upcoming>>(upcomings);
    } catch (e) {
      // ignore: always_specify_types
      return ErrorResult(e.toString());
    }
  }

  @override
  Future<BaseResult<AsianwikiType>> deeplink(String id) =>
      _apiServices.deeplinkType(id).awaitResponse;
}
