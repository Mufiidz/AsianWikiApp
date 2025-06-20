import 'package:flutter/material.dart';

import '../model/show.dart';
import '../styles/export_styles.dart';
import '../utils/export_utils.dart';
import 'export_widget.dart';

typedef OnClickItem = Function()?;

class ItemShow extends StatefulWidget {
  final Show show;
  final OnClickItem? onClick;
  const ItemShow({required this.show, super.key, this.onClick});

  @override
  State<ItemShow> createState() => _ItemShowState();
}

class _ItemShowState extends State<ItemShow>
    with SingleTickerProviderStateMixin {
  late Color _baseColor;

  @override
  void initState() {
    super.initState();
    _baseColor = getRandomDarkColor();
  }

  @override
  Widget build(BuildContext context) {
    final Show(:String id, :String title, :String? imageUrl, :String? type) =
        widget.show;
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
                  // ISSUE : FIX hero tag when entrance animation
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
              Align(
                alignment: Alignment.topCenter,
                child: type != null
                    ? Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: PaddingStyle.medium,
                          vertical: 2,
                        ),
                        decoration: const BoxDecoration(
                          color: Colors.black45,
                          borderRadius: BorderRadius.vertical(
                            bottom: Radius.circular(CornerRadius.medium),
                          ),
                        ),
                        child: Text(
                          type.toTitleCase() ?? '',
                          style: context.textTheme.bodyMedium?.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
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
}
