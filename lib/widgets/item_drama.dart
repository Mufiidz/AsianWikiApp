import 'package:flutter/material.dart';

import '../model/drama.dart';
import '../styles/export_styles.dart';
import '../utils/export_utils.dart';
import 'export_widget.dart';

typedef OnClickItem = Function()?;

class ItemDrama extends StatefulWidget {
  final Drama drama;
  final OnClickItem? onClick;
  const ItemDrama({required this.drama, super.key, this.onClick});

  @override
  State<ItemDrama> createState() => _ItemDramaState();
}

class _ItemDramaState extends State<ItemDrama> {
  late Color _baseColor;

  @override
  void initState() {
    super.initState();
    _baseColor = getRandomDarkColor();
  }

  @override
  Widget build(BuildContext context) {
    final Drama(:String? imageUrl) = widget.drama;
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
