part of 'detail_person_cubit.dart';

@MappableClass()
class DetailPersonState extends BaseState with DetailPersonStateMappable {
  final DetailPerson person;
  final bool? isFavorite;

  DetailPersonState({
    this.person = const DetailPerson(),
    super.statusState,
    super.message,
    this.isFavorite
  });
}
