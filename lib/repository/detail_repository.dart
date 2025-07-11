import 'dart:io';
import 'dart:math';

import 'package:injectable/injectable.dart';
import 'package:share_plus/share_plus.dart';
import 'package:timezone/timezone.dart' as tz;

import '../config/env.dart';
import '../config/notification/notification_channel.dart';
import '../config/notification/notification_service.dart';
import '../data/base_result.dart';
import '../data/local/dao/upcoming_reminder_dao.dart';
import '../data/network/api_services.dart';
import '../data/network/cast_response.dart';
import '../di/injection.dart';
import '../model/asianwiki_type.dart';
import '../model/cast_show.dart';
import '../model/detail_person.dart';
import '../model/detail_show.dart';
import '../model/notification_payload.dart';
import '../model/person_show.dart';
import '../model/upcoming_reminder.dart';
import '../res/export_res.dart';
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
  Future<BaseResult<String>> setReminderUpcoming(
    UpcomingReminder upcomingReminder,
  );
  Future<BaseResult<List<UpcomingReminder>>> getUpcomingReminders();
  Future<bool?> isUpcomingReminderExist(String showId);
  Future<BaseResult<String>> cancelReminderUpcoming(String showId);
}

@Injectable(as: DetailRepository)
class DetailRepositoryImpl implements DetailRepository {
  final ApiServices _apiServices;
  final NotificationService _notificationService;
  final UpcomingReminderDao _upcomingReminderDao;

  DetailRepositoryImpl(
    this._apiServices,
    this._notificationService,
    this._upcomingReminderDao,
  );

  @override
  Future<BaseResult<DetailShow>> getDetailShow(
    String id,
    String? languageCode,
  ) async {
    final BaseResult<DetailShow> response = await _apiServices
        .show(id, languageCode)
        .awaitResponse;

    if (response.isError) return response;

    DetailShow detailShow = response.onDataResult;

    final DateTime? releaseDate = detailShow.releaseDateRange?.start;
    final bool isNewUpcoming = releaseDate == null || isUpcoming(releaseDate);

    detailShow = detailShow.copyWith(isUpcoming: isNewUpcoming);

    return DataResult<DetailShow>(detailShow);
  }

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
      final ShareParams params = ShareParams(text: content);

      final ShareResult result = await getIt<SharePlus>().share(params);

      return switch (result.status) {
        ShareResultStatus.success => DataResult<String>(
          LocaleKeys.success_msg_share.tr(),
        ),
        _ => ErrorResult<String>(LocaleKeys.error_msg_share.tr()),
      };
    } catch (e) {
      logger.e(e, tag: 'shareShow');
      return ErrorResult<String>(e.toString());
    }
  }

  @override
  Future<BaseResult<String>> setReminderUpcoming(
    UpcomingReminder upcomingReminder,
  ) async {
    final UpcomingReminder(
      :AsianwikiType type,
      :int id,
      :String showId,
      :String title,
      :DateTime reminderOn,
    ) = upcomingReminder;
    try {
      if (type == AsianwikiType.unknown || type == AsianwikiType.actress) {
        return ErrorResult<String>(LocaleKeys.not_upcoming.tr());
      }

      if (!isUpcoming(reminderOn)) {
        return ErrorResult<String>(
          LocaleKeys.released_upcoming_notification.tr(),
        );
      }

      final List<String> descriptions = <String>[
        LocaleKeys.notification_upcoming_message_1.tr(
          args: <String>['${type.toValue().toTitleCase()}', title],
        ),
        LocaleKeys.notification_upcoming_message_2.tr(args: <String>[title]),
        LocaleKeys.notification_upcoming_message_3.tr(args: <String>[title]),
        LocaleKeys.notification_upcoming_message_4.tr(args: <String>[title]),
        LocaleKeys.notification_upcoming_message_5.tr(args: <String>[title]),
      ];

      final String description = descriptions.randomItem();

      final NotificationPayload notificationPayload = NotificationPayload(
        id: showId,
        type: type,
      );

      final Random random = Random();
      final String rawNotifId =
          '${NotificationChannel.upcomingChannelId}${random.nextInt(NotificationChannel.upcomingChannelId)}';
      final int notifId = int.parse(rawNotifId);

      final UpcomingReminder newUpcomingReminder = await _upcomingReminderDao
          .addUpcomingReminder(upcomingReminder.copyWith(id: notifId));

      await _notificationService.scheduleNotification(
        newUpcomingReminder.id,
        LocaleKeys.title_upcoming_notification.tr(args: <String>[title]),
        description,
        tz.TZDateTime.from(newUpcomingReminder.reminderOn, tz.local),
        NotificationChannel.upcomingNotificationDetail,
        payload: notificationPayload,
      );
      return DataResult<String>(LocaleKeys.reminder_msg_set.tr());
    } catch (e) {
      logger.e(e, tag: 'setReminderUpcoming');
      return ErrorResult<String>(e.toString());
    }
  }

  bool isUpcoming(DateTime releaseDate) => DateTime.now().isBefore(releaseDate);

  @override
  Future<BaseResult<List<UpcomingReminder>>> getUpcomingReminders() async {
    try {
      final List<UpcomingReminder> upcomingReminders =
          await _upcomingReminderDao.getUpcomingReminders();
      return DataResult<List<UpcomingReminder>>(upcomingReminders);
    } catch (e) {
      logger.e(e, tag: 'getUpcomingReminders');
      return ErrorResult<List<UpcomingReminder>>(e.toString());
    }
  }

  @override
  Future<bool?> isUpcomingReminderExist(String showId) async {
    if (showId.isEmpty) return null;
    try {
      return await _upcomingReminderDao.isUpcomingReminderExist(showId);
    } catch (e) {
      logger.e(e, tag: 'isUpcomingReminderExist');
      return null;
    }
  }

  @override
  Future<BaseResult<String>> cancelReminderUpcoming(String showId) async {
    try {
      final UpcomingReminder? upcomingReminder = await _upcomingReminderDao
          .deleteUpcomingReminder(showId);

      if (upcomingReminder == null) {
        return ErrorResult<String>(LocaleKeys.reminder_msg_notfound.tr());
      }
      await _notificationService.cancelNotification(upcomingReminder.id);
      return DataResult<String>(LocaleKeys.reminder_msg_cancel.tr());
    } catch (e) {
      return ErrorResult<String>(e.toString());
    }
  }
}
