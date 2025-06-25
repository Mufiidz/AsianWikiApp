import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../di/injection.dart';
import '../../model/favorite.dart';
import '../../res/export_res.dart';
import '../../styles/export_styles.dart';
import '../../utils/export_utils.dart';
import '../../widgets/appbar_widget.dart';
import '../../widgets/export_widget.dart';
import '../detail/person/detail_person_screen.dart';
import '../detail/show/detail_show_screen.dart';
import 'cubit/favorites_cubit.dart';
import 'item_favorite.dart';

class FavoritesScreen extends StatefulWidget {
  final FavoriteType? type;
  const FavoritesScreen({super.key, this.type});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  late final FavoritesCubit _favoriteCubit;
  late final PagingController<int, Favorite> _pagingController;
  FavoriteType _selectedFavoriteType = FavoriteType.all;

  @override
  void initState() {
    _favoriteCubit = getIt<FavoritesCubit>();
    _pagingController = PagingController<int, Favorite>(
      firstPageKey: 1,
      invisibleItemsThreshold: 2,
    );
    _selectedFavoriteType = widget.type ?? _selectedFavoriteType;
    super.initState();

    _pagingController.addPageRequestListener((int pageKey) {
      _favoriteCubit.getFavorites(page: pageKey, type: _selectedFavoriteType);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(LocaleKeys.title_favorite_screen.tr()),
      body: BlocConsumer<FavoritesCubit, FavoritesState>(
        bloc: _favoriteCubit,
        listener: (BuildContext context, FavoritesState state) {
          final FavoritesState(:String message, :List<Favorite> favorites) =
              state;
          if (state.isIdle) {
            final int? nextPage = _pagingController.nextPageKey;
            if (state.favorites.isNotEmpty && nextPage != null) {
              _pagingController.appendPage(favorites, nextPage + 1);
            } else {
              _pagingController.appendLastPage(favorites);
            }
          }

          if (state.isError) {
            _pagingController.error = message;
          }
        },
        builder: (BuildContext context, FavoritesState state) =>
            RefreshIndicator.adaptive(
              onRefresh: () {
                _pagingController.refresh();
                return Future<void>.value();
              },
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: PaddingStyle.mediumHorizontal,
                    child: Wrap(
                      spacing: Spacing.small,
                      children: List<Widget>.generate(
                        FavoriteType.values.length,
                        (int index) {
                          final FavoriteType type = FavoriteType.values[index];
                          return ChoiceChip(
                            label: Text(
                              type.name.capitalizeFirst().whenEmpty(),
                            ),
                            selected: state.selectedFavoriteType == type,
                            onSelected: (bool selected) {
                              if (selected) {
                                _selectedFavoriteType = type;
                                _pagingController.refresh();
                              }
                            },
                          );
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: PagedGridView<int, Favorite>(
                      pagingController: _pagingController,
                      padding: PaddingStyle.screen,
                      builderDelegate: PagedChildBuilderDelegate<Favorite>(
                        itemBuilder:
                            (BuildContext context, Favorite item, int index) =>
                                ItemFavorite(
                                  favorite: item,
                                  showTag:
                                      _selectedFavoriteType == FavoriteType.all,
                                  onClick: _onClickFavorite,
                                ),
                      ),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: context.mediaSize.width > 600 ? 4 : 2,
                        crossAxisSpacing: Spacing.small,
                        mainAxisSpacing: Spacing.small,
                        mainAxisExtent: context.mediaSize.width > 600
                            ? 300
                            : 250,
                      ),
                    ),
                  ),
                ],
              ),
            ),
      ),
    );
  }

  void _onClickFavorite(Favorite favorite) async {
    final FavoriteType favoriteType = FavoriteTypeMapper.ensureInitialized()
        .decode(favorite.type.toLowerCase());

    final StatefulWidget screen;

    if (favoriteType == FavoriteType.actress) {
      screen = DetailPersonScreen(person: favorite.toPerson);
    } else {
      screen = DetailShowScreen(drama: favorite.toShow);
    }

    await AppRoute.to(screen);
    _pagingController.refresh();
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}
