import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../di/injection.dart';
import '../../model/upcoming.dart';
import '../../res/constants/constants.dart' as constants;
import '../../res/locale_keys.g.dart';
import '../../styles/export_styles.dart';
import '../../utils/export_utils.dart';
import '../../widgets/export_widget.dart';
import '../search/search_screen.dart';
import 'cubit/home_cubit.dart';
import 'home_loading.dart';
import 'sections/home_header.dart';
import 'sections/upcoming_home.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final HomeCubit _cubit;
  late final PagingController<int, Upcoming> _pagingController;
  late final SearchController _searchController;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _cubit = getIt<HomeCubit>();
    _pagingController = PagingController<int, Upcoming>(
      firstPageKey: 1,
      invisibleItemsThreshold: 2,
    );
    _searchController = SearchController();

    _cubit.initial(_pagingController);
    _pagingController.addPageRequestListener((int pageKey) {
      _cubit.getUpcoming(page: pageKey);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(
        constants.appName,
        showBackButton: false,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              _searchController
                ..value = TextEditingValue(
                  text: _searchController.text,
                  selection: TextSelection(
                    baseOffset: 0,
                    extentOffset: _searchController.text.length,
                  ),
                )
                ..openView();
            },
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          RefreshIndicator.adaptive(
            onRefresh: () {
              _cubit.initial(_pagingController);
              return Future<void>.value();
            },
            child: BlocBuilder<HomeCubit, HomeState>(
              bloc: _cubit,
              builder: (BuildContext context, HomeState state) =>
                  BodyWidget<HomeState>(
                    state: state,
                    loadingBuilder: (BuildContext context, HomeState state) =>
                        const HomeLoading(),
                    child: (BuildContext context, HomeState state) {
                      final List<Widget> contents = _contents(state);
                      return ListWidget<Widget>(
                        contents,
                        controller: _scrollController,
                        itemBuilder:
                            (BuildContext context, Widget item, int index) =>
                                item,
                        separatorBuilder:
                            (BuildContext context, Widget item, int index) =>
                                Spacing.mediumSpacing,
                        isSeparated: true,
                      );
                    },
                  ),
            ),
          ),
          SearchAnchor(
            searchController: _searchController,
            isFullScreen: false,
            viewHintText: LocaleKeys.searchbar_hint.tr(),
            viewOnSubmitted: (String value) {
              _searchController
                ..closeView(value)
                ..clear();
              AppRoute.to(SearchScreen(query: value));
            },
            builder: (BuildContext context, SearchController controller) =>
                Container(),
            suggestionsBuilder:
                (BuildContext context, SearchController controller) async {
                  List<String> suggest = await _cubit.getSearchHistory(
                    query: controller.text,
                  );
                  return suggest
                      .map(
                        (String title) => ItemSearch(
                          title: title,
                          onInsert: () {
                            controller.value = TextEditingValue(
                              text: '$title ',
                            );
                          },
                          onClik: () {
                            controller
                              ..clear()
                              ..closeView(title);
                            AppRoute.to(SearchScreen(query: title));
                          },
                          onRemove: () => _cubit.removeSearchHistory(title),
                        ),
                      )
                      .toList();
                },
          ),
        ],
      ),
    );
  }

  List<Widget> _contents(HomeState state) => <Widget>[
    HomeHeader(sliders: state.sliders),
    UpcomingHome(
      controller: _pagingController,
      itemsCount: state.upcomingsLength,
      scrollController: _scrollController,
    ),
  ];

  @override
  void dispose() {
    _pagingController.dispose();
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}
