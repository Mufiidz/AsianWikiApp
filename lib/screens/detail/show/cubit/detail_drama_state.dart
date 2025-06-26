part of 'detail_drama_cubit.dart';

@MappableClass()
class DetailDramaState extends BaseState with DetailDramaStateMappable {
  final DetailShow? drama;
  final List<CastResponse> casts;
  final bool? isFavorite;

  DetailDramaState({
    super.statusState,
    super.message,
    this.drama,
    this.casts = const <CastResponse>[],
    this.isFavorite,
  });
}
