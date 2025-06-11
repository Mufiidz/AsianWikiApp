part of 'detail_person_cubit.dart';

@MappableClass()
class DetailPersonState extends BaseState with DetailPersonStateMappable {
  final DetailPerson person;

  DetailPersonState({
    this.person = const DetailPerson(),
    super.statusState,
    super.message,
  });
}
