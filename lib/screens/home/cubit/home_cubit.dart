import 'package:bloc/bloc.dart';
import 'package:dart_mappable/dart_mappable.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';

import '../../../data/base_result.dart';
import '../../../data/base_state.dart';
import '../../../model/drama.dart';
import '../../../model/upcoming.dart';
import '../../../repository/home_repository.dart';
import '../../../repository/search_repository.dart';
import '../../../utils/export_utils.dart';

part 'home_cubit.mapper.dart';
part 'home_state.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  final HomeRepository _homeRepository;
  final SearchRepository _searchRepository;
  final List<String> _errors = <String>[];
  late PagingController<int, Upcoming> _pagingController;
  HomeCubit(this._homeRepository, this._searchRepository) : super(HomeState());

  Future<void> initial(PagingController<int, Upcoming> pagingController) async {
    emit(state.copyWith(statusState: StatusState.loading));

    _pagingController = pagingController;

    _pagingController.refresh();
    _errors.clear();

    final List<Future<void>> actions = <Future<void>>[
      getSlider(),
      getUpcoming(),
    ];

    await Future.wait(actions);

    if (_errors.length == actions.length) {
      emit(
        state.copyWith(statusState: StatusState.failure, message: _errors[0]),
      );
      logger.d(_errors);
    }
  }

  Future<void> getSlider() async {
    logger.d('Hit Get Slider');

    final BaseResult<List<Drama>> result = await _homeRepository.getSlider();

    result.when(
      result:
          (List<Drama> data) => emit(
            state.copyWith(sliders: data, statusState: StatusState.idle),
          ),
      error: (String message) {
        _errors.add(message);
      },
    );
  }

  Future<void> getUpcoming({int? page}) async {
    logger.d('Hit Get Upcoming');
    final BaseResult<List<Upcoming>> result = await _homeRepository.getUpcoming(
      page: page,
    );

    final int? nextPageKey = _pagingController.nextPageKey;

    result.when(
      result: (List<Upcoming> data) {
        if (data.isNotEmpty && nextPageKey != null) {
          _pagingController.appendPage(data, nextPageKey + 1);
        } else {
          _pagingController.appendLastPage(data);
        }
        final List<Upcoming> upcomings =
            _pagingController.itemList ?? <Upcoming>[];
        emit(
          state.copyWith(
            statusState: StatusState.idle,
            upcomingsLength: upcomings.length,
          ),
        );
      },
      error: (String message) {
        _errors.add(message);
        _pagingController.error = message;
        _pagingController.appendLastPage(<Upcoming>[]);
      },
    );
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
