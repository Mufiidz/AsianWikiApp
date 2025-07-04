part of 'search_cubit.dart';

@MappableClass()
class SearchState extends BaseState with SearchStateMappable {
  final List<Search> results;

  SearchState({
    super.message,
    super.statusState,
    this.results = const <Search>[],
  });
}
