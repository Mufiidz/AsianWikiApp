part of 'favorites_cubit.dart';

@MappableClass()
class FavoritesState extends BaseState with FavoritesStateMappable {
  final List<Favorite> favorites;
  final FavoriteType selectedFavoriteType;

  FavoritesState({
    super.message,
    super.statusState,
    this.favorites = const <Favorite>[],
    this.selectedFavoriteType = FavoriteType.all,
  });
}
