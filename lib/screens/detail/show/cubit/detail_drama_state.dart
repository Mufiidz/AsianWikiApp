part of 'detail_drama_cubit.dart';

@MappableClass()
class DetailDramaState extends BaseState with DetailDramaStateMappable {
  final DetailShow? drama;
  final List<CastResponse> casts;
  final bool? isFavorite;
  final bool? isSetReminder;
  final bool? onWatchlist;

  DetailDramaState({
    super.statusState,
    super.message,
    super.statusStateScreen,
    this.drama,
    this.casts = const <CastResponse>[],
    this.isFavorite,
    this.isSetReminder,
    this.onWatchlist,
  });
}
