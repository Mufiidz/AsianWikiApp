part of 'home_cubit.dart';

@MappableClass()
class HomeState extends BaseState with HomeStateMappable {
  final List<SliderDrama> sliders;
  final int upcomingsLength;

  HomeState({
    super.message,
    super.statusState,
    this.sliders = const <SliderDrama>[],
    this.upcomingsLength = 0,
  });
}
