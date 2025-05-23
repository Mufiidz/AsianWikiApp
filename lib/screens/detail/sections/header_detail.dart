import 'package:flutter/material.dart';

import '../../../styles/padding.dart';
import '../../../utils/export_utils.dart';
import '../../../widgets/export_widget.dart';

class HeaderDetail extends StatefulWidget {
  final String heroId;
  final String image;
  final String title;
  const HeaderDetail({
    required this.image,
    required this.title,
    required this.heroId,
    super.key,
  });

  @override
  State<HeaderDetail> createState() => _HeaderDetailState();
}

class _HeaderDetailState extends State<HeaderDetail> {
  bool isImgLoaded = true;
  @override
  Widget build(BuildContext context) {
    if (widget.image.isEmpty || widget.title.isEmpty) {
      return const SizedBox.shrink();
    }
    return Column(
      children: <Widget>[
        ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(48),
            bottomRight: Radius.circular(48),
          ),
          child: Hero(
            tag: widget.heroId,
            child: ImageNetwork(
              widget.image,
              context,
              fit: BoxFit.cover,
              errorBuilder:
                  (Object? error) => Container(
                    width: context.mediaSize.width,
                    height: kToolbarHeight + 20,
                    alignment: Alignment.center,
                    child: Text(error.toString()),
                  ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: PaddingStyle.large,
            right: PaddingStyle.medium,
            left: PaddingStyle.medium,
          ),
          child: Text(
            widget.title,
            textAlign: TextAlign.center,
            style: context.textTheme.headlineLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
