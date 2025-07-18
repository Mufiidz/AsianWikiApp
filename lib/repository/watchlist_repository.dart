import 'package:injectable/injectable.dart';

import '../data/base_result.dart';
import '../data/local/dao/watch_dao.dart';
import '../model/watch.dart';
import '../res/export_res.dart';
import '../utils/export_utils.dart';

abstract class WatchlistRepository {
  Future<bool?> onWatchList(String showId);
  Future<BaseResult<String>> addWatchList(Watch watch);
  Future<BaseResult<String>> removeWatchList(String showId);
  Future<BaseResult<List<Watch>>> getWatchList();
}

@Injectable(as: WatchlistRepository)
class WatchlistRepositoryImpl implements WatchlistRepository {
  final WatchDao _watchDao;
  WatchlistRepositoryImpl(this._watchDao);

  @override
  Future<BaseResult<String>> addWatchList(Watch watch) async {
    try {
      final Watch savedWatch = await _watchDao.addWatchList(watch);

      return DataResult<String>(
        LocaleKeys.watchlist_msg_success.tr(args: <String>[savedWatch.title]),
      );
    } catch (e) {
      return ErrorResult<String>(e.toString());
    }
  }

  @override
  Future<BaseResult<List<Watch>>> getWatchList() async {
    try {
      final List<Watch> watchList = await _watchDao.getWatchList();
      return DataResult<List<Watch>>(watchList);
    } catch (e) {
      return ErrorResult<List<Watch>>(e.toString());
    }
  }

  @override
  Future<bool?> onWatchList(String showId) async {
    try {
      return await _watchDao.isWatchListExist(showId);
    } catch (e) {
      logger.e(e, tag: 'onWatchList');
      return null;
    }
  }

  @override
  Future<BaseResult<String>> removeWatchList(String showId) async {
    try {
      await _watchDao.deleteWatchList(showId);
      return DataResult<String>(LocaleKeys.watchlist_msg_remove.tr());
    } catch (e) {
      return ErrorResult<String>(e.toString());
    }
  }
}
