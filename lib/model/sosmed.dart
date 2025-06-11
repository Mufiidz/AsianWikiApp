import 'package:flutter/widgets.dart';

import '../res/assets.gen.dart';
import '../utils/export_utils.dart';

class Sosmed {
  final String title;
  final String username;

  Sosmed({this.title = '', this.username = ''});

  String? get deeplink => switch (title.toLowerCase()) {
    'instagram' => 'instagram://user?username=$username',
    'twitter' => 'https://twitter.com/$username',
    _ => null,
  };

  String? get url => switch (title.toLowerCase()) {
    'instagram' => 'https://www.instagram.com/$username',
    'twitter' => 'https://twitter.com/$username',
    'facebook' => 'https://www.facebook.com/$username',
    'tiktok' => 'https://www.tiktok.com/@$username',
    _ => null,
  };

  String? getIcon(BuildContext context) => switch (title.toLowerCase()) {
    'instagram' =>
      context.theme.isDark
          ? Assets.icons.instagramDark.path
          : Assets.icons.instagramLight.path,
    'twitter' =>
      context.theme.isDark ? Assets.icons.xDark.path : Assets.icons.xLight.path,
    'facebook' => Assets.icons.fb.path,
    'tiktok' => Assets.icons.tiktok.path,
    _ => null,
  };

  @override
  String toString() {
    return 'Sosmed(title: $title, username: $username, deeplink: $deeplink, url: $url)';
  }
}
