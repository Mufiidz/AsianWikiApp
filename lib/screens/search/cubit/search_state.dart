part of 'search_cubit.dart';

@MappableClass()
class SearchState extends BaseState with SearchStateMappable {
  final List<Drama> results;

  SearchState({
    super.message,
    super.statusState,
    this.results = const <Drama>[],
  });
}
