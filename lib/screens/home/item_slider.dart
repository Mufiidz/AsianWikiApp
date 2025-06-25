import 'package:flutter/material.dart';

import '../../model/show.dart';
import '../../styles/export_styles.dart';
import '../../utils/export_utils.dart';
import '../../widgets/export_widget.dart';
import '../detail/show/detail_show_screen.dart';

class ItemSlider extends StatelessWidget {
  final Show item;
  const ItemSlider({required this.item, super.key});

  @override
  Widget build(BuildContext context) {
    final Show(:String id, :String title, :String imageUrl) = item;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: CornerRadius.mediumRadius),
      elevation: Elevation.medium,
      child: ClipRRect(
        borderRadius: CornerRadius.mediumRadius,
        child: InkWell(
          onTap: () => AppRoute.to(DetailShowScreen(drama: item)),
          child: Stack(
            children: <Widget>[
              Hero(
                tag: id,
                child: ImageNetwork(
                  imageUrl,
                  borderRadius: CornerRadius.mediumRadius,
                  context,
                  fit: BoxFit.cover,
                  width: context.mediaSize.width,
                  height: context.mediaSize.height,
                ),
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
