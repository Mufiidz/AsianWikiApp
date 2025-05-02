import 'package:flutter/material.dart';

import '../../model/drama.dart';
import '../../styles/export_styles.dart';
import '../../utils/export_utils.dart';
import '../../widgets/export_widget.dart';

class ItemSlider extends StatelessWidget {
  final Drama item;
  const ItemSlider({required this.item, super.key});

  @override
  Widget build(BuildContext context) {
    final Drama(:String title, :String imageUrl) = item;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: CornerRadius.mediumRadius),
      elevation: Elevation.medium,
      child: ClipRRect(
        borderRadius: CornerRadius.mediumRadius,
        child: InkWell(
          onTap: () {},
          child: Stack(
            children: <Widget>[
              CachedImageNetwork(
                imageUrl,
                fit: BoxFit.cover,
                width: context.mediaSize.width,
                height: context.mediaSize.height,
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
                  style: context.textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
