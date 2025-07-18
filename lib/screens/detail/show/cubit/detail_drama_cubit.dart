import 'package:bloc/bloc.dart';
import 'package:dart_mappable/dart_mappable.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/base_result.dart';
import '../../../../data/base_state.dart';
import '../../../../data/network/cast_response.dart';
import '../../../../model/asianwiki_type.dart';
import '../../../../model/date_range.dart';
import '../../../../model/detail_show.dart';
import '../../../../model/favorite.dart';
import '../../../../model/upcoming_reminder.dart';
import '../../../../repository/detail_repository.dart';
import '../../../../repository/favorite_repository.dart';
import '../../../../utils/export_utils.dart';

part 'detail_drama_state.dart';
part 'detail_drama_cubit.mapper.dart';

@injectable
class DetailDramaCubit extends Cubit<DetailDramaState> {
  final DetailRepository _detailRepository;
  final List<String> _errors = <String>[];
  bool isEmptyCasts = false;
  final FavoriteRepository _favoriteRepository;
  DetailDramaCubit(this._detailRepository, this._favoriteRepository)
    : super(DetailDramaState());

  void getAllDetail(String id, String? langCode) async {
    if (id.isEmpty) return;
    emit(state.copyWith(statusStateScreen: StatusStateScreen.loading));
    _errors.clear();

    await checkFavorite(id);
    await _isUpcomingReminder(id);

    final List<Future<void>> actions = <Future<void>>[
      getDetail(id, langCode),
      getCasts(id),
    ];

    await Future.wait(actions);

    if (_errors.length == actions.length ||
        (_errors.length == 1 && isEmptyCasts)) {
      logger.e(_errors);
      emit(
        state.copyWith(
          statusStateScreen: StatusStateScreen.failure,
          message: _errors[0],
        ),
      );
    }
  }

  Future<void> checkFavorite(String id) {
    return _favoriteRepository.isFavorite(id).then((bool? isFavorite) {
      emit(state.copyWith(isFavorite: isFavorite));
    });
  }

  Future<void> getDetail(String id, String? langCode) async {
    bool isError = false;
    final BaseResult<DetailShow> result = await _detailRepository.getDetailShow(
      id,
      langCode,
    );

    final DetailDramaState newState = result.when(
      result: (DetailShow data) => state.copyWith(
        drama: data,
        statusStateScreen: StatusStateScreen.idle,
      ),
      error: (String message) {
        isError = true;
        return state.copyWith(
          statusStateScreen: StatusStateScreen.idle,
          message: message,
        );
      },
    );

    if (isError) {
      _errors.add(newState.message);
      return;
    }
    emit(newState);
  }

  Future<void> getCasts(String id) async {
    bool isError = false;
    final BaseResult<List<CastResponse>> result = await _detailRepository
        .getCasts(id);

    final DetailDramaState newState = result.when(
      result: (List<CastResponse> data) {
        isEmptyCasts = data.isEmpty;
        return state.copyWith(
          casts: data,
          statusStateScreen: StatusStateScreen.idle,
        );
      },
      error: (String message) {
        isError = true;
        return state.copyWith(
          statusStateScreen: StatusStateScreen.idle,
          message: message,
        );
      },
    );

    if (isError) {
      _errors.add(newState.message);
      return;
    }
    emit(newState);
  }

  void toggleFavorite() async {
    bool? isFavorite = state.isFavorite;
    if (isFavorite == null) return null;

    final DetailDramaState newState;
    if (!isFavorite) {
      newState = await _addFavorite();
    } else {
      newState = await _unFavorite();
    }
    emit(newState);
  }

  Future<DetailDramaState> _addFavorite() async {
    final DetailShow? drama = state.drama;
    if (drama == null) return state;

    final BaseResult<Favorite> result = await _favoriteRepository.addFavorite(
      drama.toFavorite,
    );

    final DetailDramaState newState = result.when(
      result: (Favorite data) => state.copyWith(isFavorite: true),
      error: (String message) => state.copyWith(message: message),
    );
    return newState;
  }

  Future<DetailDramaState> _unFavorite() async {
    final DetailShow? drama = state.drama;
    if (drama == null || drama.id.isEmpty) return state;
    final BaseResult<String> result = await _favoriteRepository.deleteFavorite(
      drama.id,
    );

    final DetailDramaState newState = result.when(
      result: (String data) => state.copyWith(isFavorite: false, message: data),
      error: (String message) => state.copyWith(message: message),
    );
    return newState;
  }

  void shareShow() async {
    final DetailShow? show = state.drama;
    if (show == null) return;
    await _detailRepository.share(
      id: show.id,
      title: show.title,
      type: show.type.toAsianWikiType,
    );
  }

  void reminderUpcoming() async {
    final DetailShow? show = state.drama;
    if (show == null) return;
    final String showId = show.id;
    emit(state.copyWith(statusState: StatusState.loading));
    final bool? isReminderExist = await _detailRepository
        .isUpcomingReminderExist(showId);

    if (isReminderExist == null) {
      emit(state.copyWith(statusState: StatusState.idle));
      return;
    }

    if (isReminderExist) {
      cancelReminderUpcoming();
    } else {
      setReminderUpcoming();
    }
  }

  void setReminderUpcoming() async {
    final DetailShow? show = state.drama;
    if (show == null) return;
    final DetailShow(
      :String id,
      :String title,
      :String releaseDate,
      :DateRange? releaseDateRange,
      :ShowType? type,
    ) = show;
    final BaseResult<String> result = await _detailRepository
        .setReminderUpcoming(
          UpcomingReminder(
            reminderOn: releaseDateRange?.start ?? DateTime.parse(releaseDate),
            showId: id,
            title: title,
            type: type?.toAsianWikiType ?? AsianwikiType.unknown,
          ),
        );

    final DetailDramaState newState = result.when(
      result: (String data) => state.copyWith(
        message: data,
        statusState: StatusState.success,
        isSetReminder: true,
      ),
      error: (String message) =>
          state.copyWith(message: message, statusState: StatusState.failure),
    );

    emit(newState);
  }

  void cancelReminderUpcoming() async {
    final DetailShow? show = state.drama;
    if (show == null) return;
    final String showId = show.id;
    final BaseResult<String> result = await _detailRepository
        .cancelReminderUpcoming(showId);

    final DetailDramaState newState = result.when(
      result: (String data) => state.copyWith(
        message: data,
        statusState: StatusState.success,
        isSetReminder: false,
      ),
      error: (String message) =>
          state.copyWith(message: message, statusState: StatusState.failure),
    );

    emit(newState);
  }

  Future<void> _isUpcomingReminder(String id) async {
    final bool? isReminderExist = await _detailRepository
        .isUpcomingReminderExist(id);

    emit(state.copyWith(isSetReminder: isReminderExist));
  }
}
