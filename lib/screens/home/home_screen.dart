import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../di/injection.dart';
import '../../model/upcoming.dart';
import '../../styles/export_styles.dart';
import '../../utils/export_utils.dart';
import '../../widgets/appbar_widget.dart';
import '../../widgets/list_widget.dart';
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

  @override
  void initState() {
    _cubit = getIt<HomeCubit>();
    _pagingController = PagingController<int, Upcoming>(
      firstPageKey: 1,
      invisibleItemsThreshold: 2,
    );
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
        'AsianWiki',
        showBackButton: false,
        actions: <Widget>[
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
        ],
      ),
      body: RefreshIndicator.adaptive(
        onRefresh: () => _cubit.initial(_pagingController),
        child: BlocBuilder<HomeCubit, HomeState>(
          bloc: _cubit,
          builder: (BuildContext context, HomeState state) {
            if (state.isLoading) {
              return HomeLoading(isLoading: state.isLoading);
            }

            if (state.isError) {
              return SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Container(
                  width: context.mediaSize.width,
                  height: context.heightWithToolbar,
                  padding: PaddingStyle.mediumHorizontal,
                  alignment: Alignment.center,
                  child: Text(
                    state.message,
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: context.colorScheme.error,
                    ),
                  ),
                ),
              );
            }

            final List<Widget> contents = _contents(state);
            return ListWidget<Widget>(
              contents,
              itemBuilder:
                  (BuildContext context, Widget item, int index) => item,
              separatorBuilder:
                  (BuildContext context, Widget item, int index) =>
                      Spacing.mediumSpacing,
              isSeparated: true,
            );
          },
        ),
      ),
    );
  }

  List<Widget> _contents(HomeState state) => <Widget>[
    HomeHeader(sliders: state.sliders),
    UpcomingHome(
      controller: _pagingController,
      itemsCount: state.upcomingsLength,
    ),
  ];

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}
