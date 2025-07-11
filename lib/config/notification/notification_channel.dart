import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../res/export_res.dart';

class NotificationChannel {
  factory NotificationChannel() => _instance;

  NotificationChannel._();

  static final NotificationChannel _instance = NotificationChannel._();

  static const int generalChannelId = 990;
  static const int upcomingChannelId = 991;
  static const int weeklyOfferChannelId = 992;

  static const String generalChannel = 'general_channel';
  static const String upcomingChannel = 'upcoming_channel';
  static const String weeklyOfferChannel = 'weekly_offer_channel';

  static const String generalChannelName = 'General';
  static const String upcomingChannelName = 'Upcoming';
  static const String weeklyOfferChannelName = 'Weekly Offer';

  static const String groupKey = 'com.android.example.WORK_EMAIL';

  static NotificationDetails generalNotificationDetail = NotificationDetails(
    android: AndroidNotificationDetails(
      generalChannel,
      generalChannelName,
      channelDescription: LocaleKeys.general_channel_notification_description
          .tr(),
      importance: Importance.defaultImportance,
      priority: Priority.defaultPriority,
      playSound: true,
      enableVibration: true,
    ),
    iOS: const DarwinNotificationDetails(threadIdentifier: generalChannel),
  );

  static NotificationDetails weeklyNotificationDetail = NotificationDetails(
    android: AndroidNotificationDetails(
      weeklyOfferChannel,
      weeklyOfferChannelName,
      channelDescription: LocaleKeys.weekly_channel_notification_description
          .tr(),
      importance: Importance.defaultImportance,
      priority: Priority.defaultPriority,
      playSound: true,
      enableVibration: true,
    ),
    iOS: const DarwinNotificationDetails(threadIdentifier: weeklyOfferChannel),
  );

  static NotificationDetails upcomingNotificationDetail = NotificationDetails(
    android: AndroidNotificationDetails(
      upcomingChannel,
      upcomingChannelName,
      channelDescription: LocaleKeys.upcoming_channel_notification_description
          .tr(),
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      enableVibration: true,
      groupKey: groupKey,
    ),
    iOS: const DarwinNotificationDetails(threadIdentifier: upcomingChannel),
  );
}
