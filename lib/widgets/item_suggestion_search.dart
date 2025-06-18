import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../res/locale_keys.g.dart';
import '../utils/export_utils.dart';

typedef OnClik = void Function();

class ItemSuggestionSearch extends StatefulWidget {
  final String title;
  final OnClik? onClik;
  final OnClik? onInsert;
  final OnClik? onRemove;
  const ItemSuggestionSearch({
    required this.title,
    super.key,
    this.onClik,
    this.onInsert,
    this.onRemove,
  });

  @override
  State<ItemSuggestionSearch> createState() => _ItemSuggestionSearchState();
}

class _ItemSuggestionSearchState extends State<ItemSuggestionSearch> {
  bool isDeleted = false;
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: !isDeleted,
      child: ListTile(
        title: Text(widget.title),
        leading: const Icon(Icons.history),
        trailing: IconButton(
          onPressed: widget.onInsert,
          icon: Transform.rotate(
            angle: -45.degreesToRadian,
            child: const Icon(Icons.arrow_upward),
          ),
        ),
        onTap: widget.onClik,
        onLongPress: () => showDeleteDialog(context),
      ),
    );
  }

  void showDeleteDialog(BuildContext context) {
    showAdaptiveDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog.adaptive(
        title: Text(widget.title),
        content: Text(LocaleKeys.content_search_history.tr()),
        actions: <Widget>[
          TextButton(
            onPressed: () => AppRoute.back(context),
            child: Text(LocaleKeys.cancel.tr()),
          ),
          TextButton(
            onPressed: () {
              widget.onRemove?.call();
              setState(() => isDeleted = true);
              AppRoute.back(context);
            },
            child: Text(LocaleKeys.remove.tr()),
          ),
        ],
      ),
    );
  }
}
