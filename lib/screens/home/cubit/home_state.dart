part of 'home_cubit.dart';

@MappableClass()
class HomeState extends BaseState with HomeStateMappable {
  final List<Drama> sliders;
  final int upcomingsLength;

  HomeState({
    super.message,
    super.statusState,
    this.sliders = const <Drama>[],
    this.upcomingsLength = 0,
  });
}
