import 'package:dart_mappable/dart_mappable.dart';

import 'asianwiki_type.dart';

part 'notification_payload.mapper.dart';

@MappableClass()
class NotificationPayload with NotificationPayloadMappable {
  final String id;
  final AsianwikiType type;

  const NotificationPayload({this.id = '', this.type = AsianwikiType.unknown});

}