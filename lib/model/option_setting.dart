import 'package:flutter/material.dart';

class OptionSetting<T> {
  final String title;
  final String? subtitle;
  final Widget? icon;
  final T value;

  OptionSetting(
    this.value, {
    required this.title,
    this.subtitle,
    this.icon,
  });
}
