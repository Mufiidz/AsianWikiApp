import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/base_result.dart';
import '../data/network/api_services.dart';
import '../model/search.dart';
import '../model/search_type.dart';
import '../res/constants/sharedpref_keys.dart' as sharedpref_keys;
import '../utils/export_utils.dart';

abstract class SearchRepository {
  Future<BaseResult<List<Search>>> searchDrama(
    String title, {
    SearchType type = SearchType.all,
  });
  Future<void> saveSearchHistory(String title);
  Future<List<String>?> getSearchHistory();
  Future<void> removeSearchHistory(String title);
  Future<void> removeAllSearchHistory();
}

@Injectable(as: SearchRepository)
class SearchRepositoryImpl implements SearchRepository {
  final ApiServices _apiServices;
  final SharedPreferencesAsync _preferencesAsync;
  List<String> _searchHistories = <String>[];

  SearchRepositoryImpl(this._apiServices, this._preferencesAsync);

  @override
  Future<BaseResult<List<Search>>> searchDrama(
    String title, {
    SearchType type = SearchType.all,
  }) => _apiServices.search(title, type).awaitResponse;

  @override
  Future<List<String>?> getSearchHistory() async =>
      await _preferencesAsync.getStringList(sharedpref_keys.searchHistories);

  @override
  Future<void> saveSearchHistory(String title) async {
    _searchHistories = await getSearchHistory() ?? <String>[];

    if (_searchHistories.contains(title)) {
      _searchHistories.remove(title);
    }

    _searchHistories.insert(0, title.trim().toLowerCase());

    return _preferencesAsync.setStringList(
      sharedpref_keys.searchHistories,
      _searchHistories,
    );
  }

  @override
  Future<void> removeAllSearchHistory() =>
      _preferencesAsync.remove(sharedpref_keys.searchHistories);

  @override
  Future<void> removeSearchHistory(String title) async {
    _searchHistories = await getSearchHistory() ?? <String>[];

    if (_searchHistories.isEmpty) return;

    if (_searchHistories.contains(title)) {
      _searchHistories.remove(title);
    }

    await _preferencesAsync.setStringList(
      sharedpref_keys.searchHistories,
      _searchHistories,
    );
  }
}
