import 'package:flutter/material.dart';

import '../../../../widgets/bookmark_icon.dart';
import '../../../../widgets/export_widget.dart';

typedef OnClickShare = void Function()?;

typedef OnClickBookmark = void Function()?;

class AdditionalButtonShow extends StatelessWidget {
  final OnClickShare onClickShare;
  final OnClickBookmark onClickBookmark;
  final bool isBookmark;
  final AnimationController bookmarkController;
  const AdditionalButtonShow({
    required this.isBookmark,
    required this.bookmarkController,
    super.key,
    this.onClickShare,
    this.onClickBookmark,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        CircleButtonWidget(
          onPressed: onClickBookmark,
          child: BookmarkIcon(
            isBookmark: isBookmark,
            bookmarkController: bookmarkController,
          ),
        ),
        CircleButtonWidget.icon(Icons.share, onPressed: onClickShare),
      ],
    );
  }
}
