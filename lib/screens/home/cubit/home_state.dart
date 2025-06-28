part of 'home_cubit.dart';

@MappableClass()
class HomeState extends BaseState with HomeStateMappable {
  final List<Show> sliders;
  final int upcomingsLength;
  final List<Favorite> favoriteActress;
  final List<Favorite> favoriteDramas;
  final List<Favorite> favoriteMovies;

  HomeState({
    super.message,
    super.statusState,
    this.sliders = const <Show>[],
    this.upcomingsLength = 0,
    this.favoriteActress = const <Favorite>[],
    this.favoriteDramas = const <Favorite>[],
    this.favoriteMovies = const <Favorite>[],
  });
}
