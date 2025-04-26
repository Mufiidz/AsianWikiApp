import 'package:flutter/material.dart';

import '../../model/upcoming.dart';
import '../../styles/export_styles.dart';
import '../../utils/export_utils.dart';
import '../../widgets/export_widget.dart';

typedef OnClickItem = Function()?;

class ItemUpcoming extends StatefulWidget {
  final Upcoming drama;
  final OnClickItem? onClick;
  const ItemUpcoming({required this.drama, super.key, this.onClick});

  @override
  State<ItemUpcoming> createState() => _ItemUpcomingState();
}

class _ItemUpcomingState extends State<ItemUpcoming> {
  late Color _baseColor;

  @override
  void initState() {
    super.initState();
    _baseColor = getRandomDarkColor();
  }

  @override
  Widget build(BuildContext context) {
    final Upcoming(:String? imageUrl) = widget.drama;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: CornerRadius.mediumRadius),
      elevation: Elevation.small,
      color: (imageUrl == null || imageUrl.isEmpty) ? _baseColor : null,
      child: ClipRRect(
        borderRadius: CornerRadius.mediumRadius,
        child: InkWell(
          onTap: widget.onClick,
          borderRadius: CornerRadius.mediumRadius,
          child: Stack(
            children: <Widget>[
              Builder(
                builder: (BuildContext context) {
                  if (imageUrl == null || imageUrl.isEmpty) {
                    return const SizedBox.shrink();
                  }
                  return CachedImageNetwork(
                    imageUrl,
                    fit: BoxFit.cover,
                    width: context.mediaSize.width,
                    height: context.mediaSize.height,
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
                  widget.drama.title,
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
}
