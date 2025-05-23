import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../res/locale_keys.g.dart';
import '../../../widgets/circle_button_widget.dart';

typedef SuggestionsBuilder =
    FutureOr<Iterable<Widget>> Function(BuildContext, SearchController);

class SearchCast extends StatelessWidget {
  final SearchController searchController;
  final SuggestionsBuilder? suggestionsBuilder;
  const SearchCast({
    required this.searchController,
    this.suggestionsBuilder,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SearchAnchor(
      searchController: searchController,
      isFullScreen: true,
      viewHintText: LocaleKeys.hint_cast.tr(),
      viewOnSubmitted: (String value) => searchController.closeView(value),
      builder:
          (BuildContext context, SearchController controller) =>
              CircleButtonWidget.icon(
                Icons.search,
                onPressed: () => searchController.openView(),
              ),
      suggestionsBuilder: (BuildContext context, SearchController controller) {
        return suggestionsBuilder?.call(context, controller) ?? <Widget>[];
      },
    );
  }
}
