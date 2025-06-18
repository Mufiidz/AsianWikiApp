import 'package:flutter/material.dart';

import '../../model/person.dart';
import '../../model/search.dart';
import '../../model/search_type.dart';
import '../../model/show.dart';
import '../../styles/export_styles.dart';
import '../../utils/export_utils.dart';
import '../../widgets/export_widget.dart';
import '../detail/person/detail_person_screen.dart';
import '../detail/show/detail_show_screen.dart';

typedef OnClickItem = Function()?;

class ItemSearch extends StatefulWidget {
  final Search search;
  const ItemSearch({required this.search, super.key});

  @override
  State<ItemSearch> createState() => _ItemSearchState();
}

class _ItemSearchState extends State<ItemSearch>
    with SingleTickerProviderStateMixin {
  late Color _baseColor;

  @override
  void initState() {
    super.initState();
    _baseColor = getRandomDarkColor();
  }

  @override
  Widget build(BuildContext context) {
    final Search(
      :String id,
      :SearchType type,
      :String? imageUrl,
      :String title,
    ) = widget.search;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: CornerRadius.mediumRadius),
      elevation: Elevation.small,
      color: (imageUrl == null || imageUrl.isEmpty) ? _baseColor : null,
      child: ClipRRect(
        borderRadius: CornerRadius.mediumRadius,
        child: InkWell(
          onTap: () => _onClickItem(type, id),
          borderRadius: CornerRadius.mediumRadius,
          child: Stack(
            children: <Widget>[
              Builder(
                builder: (BuildContext context) {
                  if (imageUrl == null || imageUrl.isEmpty) {
                    return const SizedBox.shrink();
                  }
                  return Hero(
                    tag: id,
                    child: ImageNetwork(
                      imageUrl,
                      context,
                      borderRadius: CornerRadius.mediumRadius,
                      fit: BoxFit.cover,
                      width: context.mediaSize.width,
                      height: context.mediaSize.height,
                    ),
                  );
                },
              ),
              Container(
                width: context.mediaSize.width,
                height: context.mediaSize.height,
                alignment: Alignment.bottomCenter,
                padding: PaddingStyle.paddingH8V16,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: <Color>[
                      Colors.transparent,
                      Colors.black45,
                      Colors.black,
                    ],
                  ),
                ),
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: Colors.white,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onClickItem(SearchType type, String id) {
    if (type == SearchType.drama || type == SearchType.movie) {
      AppRoute.to(DetailShowScreen(drama: Show(id: id)));
    }
    if (type == SearchType.name) {
      AppRoute.to(DetailPersonScreen(person: Person(id: id)));
    }
  }
}
