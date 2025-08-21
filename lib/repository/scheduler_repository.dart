import 'package:injectable/injectable.dart';

import '../config/notification/notification_channel.dart';
import '../config/notification/notification_service.dart';
import '../data/base_result.dart';
import '../model/detail_show.dart';
import '../model/notification_payload.dart';
import '../model/watch.dart';
import '../utils/export_utils.dart';
import 'watchlist_repository.dart';

abstract class SchedulerRepository {
  Future<void> weeklyShow();
}

@Injectable(as: SchedulerRepository)
class SchedulerRepositoryImpl implements SchedulerRepository {
  final NotificationService _notificationService;
  final WatchlistRepository _watchlistRepository;

  SchedulerRepositoryImpl(this._notificationService, this._watchlistRepository);

  @override
  Future<void> weeklyShow() async {
    try {
      final BaseResult<List<Watch>> response = await _watchlistRepository
          .getWatchList();

      if (response.isError) {
        throw response;
      }

      final List<Watch> watchList = response.onDataResult;
      logger.d(watchList);
      final Watch(:String title, :String id, :ShowType? type) = watchList
          .randomItem();

      logger.d(title);

      final String? showType = type?.name.toTitleCase();

      final List<String> descriptions = <String>[
        '$showType $title masih nunggu kamu di watchlist, yuk mulai nonton sekarang!',
        '$title udah lama di watchlist kamu, waktunya kasih waktu buat nonton yuk!',
        'Masih inget $title? Ada di watchlist kamu, pas banget buat ditonton hari ini!',
        '$title siap nemenin harimu! Ada di watchlist kamu, tinggal klik play!',
        'Hey, $title belum kamu tonton lho! Yuk buka watchlist dan mulai petualangannya!',
      ];

      final String description = descriptions.randomItem();

      final NotificationPayload notificationPayload = NotificationPayload(
        id: id,
        type: type.toAsianWikiType,
      );

      await _notificationService.showNotification(
        NotificationChannel.weeklyOfferChannelId,
        '$title on Watchlist',
        description,
        NotificationChannel.weeklyNotificationDetail,
        payload: notificationPayload,
      );
    } catch (e) {
      logger.e(e);
    }
  }
}
