import 'package:bloc/bloc.dart';
import 'package:dart_mappable/dart_mappable.dart';
import 'package:injectable/injectable.dart';

import '../../../data/base_result.dart';
import '../../../data/base_state.dart';
import '../../../model/show.dart';
import '../../../repository/search_repository.dart';
import '../../../utils/logger.dart';

part 'search_state.dart';
part 'search_cubit.mapper.dart';

@injectable
class SearchCubit extends Cubit<SearchState> {
  final SearchRepository _searchRepository;

  SearchCubit(this._searchRepository) : super(SearchState());

  Future<void> searchDrama(String? title) async {
    if (title == null || title.isEmpty) return;
    emit(state.copyWith(statusState: StatusState.loading));

    await _searchRepository.saveSearchHistory(title);

    final BaseResult<List<Show>> result = await _searchRepository.searchDrama(
      title,
    );

    final SearchState newState = result.when(
      result: (List<Show> data) {
        logger.d('Search Result: $data');
        return state.copyWith(statusState: StatusState.success, results: data);
      },
      error:
          (String message) => state.copyWith(
            statusState: StatusState.failure,
            message: message,
          ),
    );
    emit(newState);
  }

  Future<List<String>> getSearchHistory({String? query}) async {
    List<String>? searchHistories = await _searchRepository.getSearchHistory();

    if (query != null && query.isNotEmpty) {
      searchHistories =
          searchHistories
              ?.where(
                (String element) =>
                    element.toLowerCase().contains(query.toLowerCase()),
              )
              .toList();
    }

    return searchHistories ?? List<String>.empty();
  }

  Future<void> removeSearchHistory(String title) =>
      _searchRepository.removeSearchHistory(title);
}
