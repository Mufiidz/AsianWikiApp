import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../di/injection.dart';
import '../../model/person.dart';
import '../../model/search.dart';
import '../../model/search_type.dart';
import '../../res/locale_keys.g.dart';
import '../../styles/export_styles.dart';
import '../../utils/export_utils.dart';
import '../../widgets/export_widget.dart';
import '../detail/person/detail_person_screen.dart';
import '../detail/show/detail_show_screen.dart';
import 'cubit/search_cubit.dart';

class SearchScreen extends StatefulWidget {
  final String? query;
  const SearchScreen({super.key, this.query});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late SearchController _searchController;
  late SearchCubit _cubit;
  bool isOpen = false;

  @override
  void initState() {
    super.initState();
    _searchController = SearchController();
    _cubit = getIt<SearchCubit>();
    final String? query = widget.query;

    if (query != null && query.isNotEmpty) {
      _cubit.searchDrama(query);
      _searchController.value = TextEditingValue(
        text: query,
        selection: TextSelection(baseOffset: 0, extentOffset: query.length),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        forceMaterialTransparency: true,
        toolbarHeight: kToolbarHeight + 20,
        title: SearchAnchor.bar(
          barHintText: LocaleKeys.searchbar_hint.tr(),
          viewHintText: LocaleKeys.searchbar_hint.tr(),
          searchController: _searchController,
          barLeading: const BackButton(),
          barTrailing: <Widget>[
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () => _searchController.openView(),
              onLongPress: () => _cubit.searchDrama(_searchController.text),
            ),
          ],
          isFullScreen: false,

          onSubmitted: (String? value) {
            _searchController.closeView(value);
            _cubit.searchDrama(value);
          },
          onTap: () {
            _searchController.value = TextEditingValue(
              text: _searchController.text,
              selection: TextSelection(
                baseOffset: 0,
                extentOffset: _searchController.text.length,
              ),
            );
          },
          suggestionsBuilder:
              (BuildContext context, SearchController controller) async {
                final List<String> suggest = await _cubit.getSearchHistory(
                  query: controller.text,
                );

                return suggest.map(
                  (String title) => ItemSuggestionSearch(
                    title: title,
                    onInsert: () {
                      controller.value = TextEditingValue(text: '$title ');
                    },
                    onClik: () {
                      controller
                        ..clear()
                        ..closeView(title);
                      _cubit.searchDrama(title);
                    },
                    onRemove: () => _cubit.removeSearchHistory(title),
                  ),
                );
              },
        ),
      ),
      body: RefreshIndicator.adaptive(
        onRefresh: () async {
          _cubit.searchDrama(_searchController.text);
          return Future<void>.value();
        },
        child: BlocBuilder<SearchCubit, SearchState>(
          bloc: _cubit,
          builder: (BuildContext context, SearchState state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator.adaptive());
            }
            if (state.isError) {
              return ErrorScreen(errorMessage: state.message);
            }
            if (state.results.isEmpty) {
              return Center(child: Text(LocaleKeys.empty_data.tr()));
            }
            return GridView.builder(
              padding: const EdgeInsets.only(
                top: PaddingStyle.small,
                left: PaddingStyle.medium,
                right: PaddingStyle.medium,
                bottom: PaddingStyle.medium,
              ),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: context.mediaSize.width > 600 ? 4 : 2,
                crossAxisSpacing: Spacing.small,
                mainAxisSpacing: Spacing.small,
                mainAxisExtent: context.mediaSize.width > 600 ? 300 : 250,
              ),
              itemCount: state.results.length,
              itemBuilder: (BuildContext context, int index) {
                final Search search = state.results[index];
                return ItemShow(
                  show: search.toShow,
                  onClick: () => _onClickItem(search),
                );
              },
            );
          },
        ),
      ),
    );
  }

  void _onClickItem(Search search) {
    final Search(:String id, :SearchType type) = search;
    if (type == SearchType.drama || type == SearchType.movie) {
      AppRoute.to(DetailShowScreen(drama: search.toShow));
    }
    if (type == SearchType.name) {
      AppRoute.to(DetailPersonScreen(person: Person(id: id)));
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
