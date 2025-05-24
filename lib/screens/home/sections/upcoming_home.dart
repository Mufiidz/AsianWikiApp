import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../model/upcoming.dart';
import '../../../res/locale_keys.g.dart';
import '../../../styles/export_styles.dart';
import '../../../utils/export_utils.dart';
import '../../../widgets/item_drama.dart';
import '../../detail/detail_show_screen.dart';

class UpcomingHome extends StatelessWidget {
  final PagingController<int, Upcoming> controller;
  final ScrollController? scrollController;
  final int itemsCount;
  const UpcomingHome({
    required this.controller,
    super.key,
    this.itemsCount = 0,
    this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        if (itemsCount == 0) {
          return const SizedBox.shrink();
        }
        return Padding(
          padding: PaddingStyle.screen,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                LocaleKeys.title_upcoming_home.tr(),
                style: context.textTheme.titleLarge,
              ),
              Spacing.mediumSpacing,
              PagedGridView<int, Upcoming>(
                pagingController: controller,
                shrinkWrap: true,
                scrollController: scrollController,
                physics: const NeverScrollableScrollPhysics(),
                padding: PaddingStyle.onlyBottomM,
                showNewPageProgressIndicatorAsGridChild: false,
                showNoMoreItemsIndicatorAsGridChild: false,
                showNewPageErrorIndicatorAsGridChild: false,
                builderDelegate: PagedChildBuilderDelegate<Upcoming>(
                  itemBuilder:
                      (BuildContext context, Upcoming item, int index) =>
                          ItemDrama(
                            drama: item.toDrama(),
                            onClick: () => AppRoute.to(
                              DetailShowScreen(drama: item.toDrama()),
                            ),
                          ),
                  newPageProgressIndicatorBuilder: (BuildContext context) =>
                      const Center(child: CircularProgressIndicator()),
                ),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: context.mediaSize.width > 600 ? 4 : 2,
                  crossAxisSpacing: Spacing.small,
                  mainAxisSpacing: Spacing.small,
                  mainAxisExtent: context.mediaSize.width > 600 ? 300 : 250,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
