part of 'home_cubit.dart';

@MappableClass()
class HomeState extends BaseState with HomeStateMappable {
  final List<Show> sliders;
  final int upcomingsLength;

  HomeState({
    super.message,
    super.statusState,
    this.sliders = const <Show>[],
    this.upcomingsLength = 0,
  });
}
