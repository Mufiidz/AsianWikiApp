part of 'detail_drama_cubit.dart';

@MappableClass()
class DetailDramaState extends BaseState with DetailDramaStateMappable {
  final DetailDrama? drama;
  DetailDramaState({super.statusState, super.message, this.drama});
}
