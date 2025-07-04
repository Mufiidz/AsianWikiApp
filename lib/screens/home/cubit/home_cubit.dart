import 'package:bloc/bloc.dart';
import 'package:dart_mappable/dart_mappable.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';

import '../../../data/base_result.dart';
import '../../../data/base_state.dart';
import '../../../model/favorite.dart';
import '../../../model/show.dart';
import '../../../model/upcoming.dart';
import '../../../repository/favorite_repository.dart';
import '../../../repository/home_repository.dart';
import '../../../repository/search_repository.dart';
import '../../../utils/export_utils.dart';

part 'home_cubit.mapper.dart';
part 'home_state.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  final HomeRepository _homeRepository;
  final SearchRepository _searchRepository;
  final FavoriteRepository _favoriteRepository;
  final List<String> _errors = <String>[];
  late PagingController<int, Upcoming> _pagingController;
  int currentPage = 1;
  HomeCubit(
    this._homeRepository,
    this._searchRepository,
    this._favoriteRepository,
  ) : super(HomeState());

  Future<void> initial(PagingController<int, Upcoming> pagingController) async {
    emit(state.copyWith(statusState: StatusState.loading));

    _pagingController = pagingController;

    _pagingController.refresh();
    _errors.clear();
    currentPage = 1;

    int page = _pagingController.nextPageKey ?? _pagingController.firstPageKey;

    final List<Future<void>> actions = <Future<void>>[
      getSlider(),
      getUpcoming(page: page),
      getFavoriteDrama(),
      getFavoriteActress(),
      getFavoriteMovie(),
    ];

    await Future.wait(actions);

    if (_errors.length == actions.length &&
        (_pagingController.itemList == null ||
            _pagingController.itemList?.isEmpty == true)) {
      emit(
        state.copyWith(statusState: StatusState.failure, message: _errors[0]),
      );
      logger.d(_errors);
    }
  }

  Future<void> getSlider() async {
    logger.d('Hit Get Slider');

    final BaseResult<List<Show>> result = await _homeRepository.getSlider();

    result.when(
      result: (List<Show> data) =>
          emit(state.copyWith(sliders: data, statusState: StatusState.idle)),
      error: (String message) {
        _errors.add(message);
      },
    );
  }

  Future<void> getUpcoming({int? page}) async {
    if (page == null || page != currentPage) return;
    final BaseResult<List<Upcoming>> result = await _homeRepository.getUpcoming(
      page: page,
    );

    final int? nextPageKey = _pagingController.nextPageKey;

    result.when(
      result: (List<Upcoming> data) {
        currentPage++;
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
      searchHistories = searchHistories
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

  Future<void> getFavoriteActress() async {
    final BaseResult<List<Favorite>> result = await _favoriteRepository
        .getFavoriteActress(size: 6);
    result.when(
      result: (List<Favorite> data) {
        emit(state.copyWith(favoriteActress: data));
      },
      error: (String message) => _errors.add(message),
    );
  }

  Future<void> getFavoriteDrama() async {
    final BaseResult<List<Favorite>> result = await _favoriteRepository
        .getFavoriteDramas(size: 6);
    result.when(
      result: (List<Favorite> data) {
        emit(state.copyWith(favoriteDramas: data));
      },
      error: (String message) => _errors.add(message),
    );
  }

  Future<void> getFavoriteMovie() async {
    final BaseResult<List<Favorite>> result = await _favoriteRepository
        .getFavoriteMovies(size: 6);
    result.when(
      result: (List<Favorite> data) {
        emit(state.copyWith(favoriteMovies: data));
      },
      error: (String message) => _errors.add(message),
    );
  }
}
