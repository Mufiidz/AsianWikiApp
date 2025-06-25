import 'package:flutter/material.dart';

import '../styles/padding.dart';

class CircleButtonWidget extends ElevatedButton {
  final double? size;
  final double? iconSize;
  final double? paddingSize;

  CircleButtonWidget({
    required super.onPressed,
    required super.child,
    super.key,
    this.size,
    this.iconSize,
    this.paddingSize,
  }) : super(
         style: ElevatedButton.styleFrom(
           shape: const CircleBorder(),
           iconSize: iconSize ?? 24,
           padding: EdgeInsets.all(paddingSize ?? PaddingStyle.small),
           fixedSize: Size.square(size ?? 48),
         ),
       );

  CircleButtonWidget.icon(
    IconData icon, {
    required super.onPressed,
    super.key,
    this.paddingSize,
    this.iconSize,
    this.size,
    Color? iconColor,
  }) : super(
         style: ElevatedButton.styleFrom(
           shape: const CircleBorder(),
           iconSize: iconSize ?? 24,
           padding: EdgeInsets.all(paddingSize ?? PaddingStyle.small),
           fixedSize: Size.square(size ?? 48),
         ),
         child: Icon(icon, color: iconColor),
       );
}
