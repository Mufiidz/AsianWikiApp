part of 'deeplink_cubit.dart';

@MappableClass()
class DeeplinkState extends BaseState with DeeplinkStateMappable {
  final AsianwikiType type;

  DeeplinkState({
    super.message,
    super.statusState,
    this.type = AsianwikiType.unknown,
  });
}
