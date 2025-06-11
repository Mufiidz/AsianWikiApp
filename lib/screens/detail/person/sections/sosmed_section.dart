import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../model/sosmed.dart';
import '../../../../styles/export_styles.dart';
import '../../../../utils/export_utils.dart';
import '../../../webview/webview_screen.dart';

class SosmedSection extends StatelessWidget {
  final List<Sosmed>? sosmeds;
  const SosmedSection({super.key, this.sosmeds});

  @override
  Widget build(BuildContext context) {
    final List<Sosmed>? sosmeds = this.sosmeds;
    if (sosmeds == null || sosmeds.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(bottom: PaddingStyle.medium),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: sosmeds.map((Sosmed item) {
          final String? icon = item.getIcon(context);
          if (icon == null || icon.isEmpty) return const SizedBox.shrink();
          return Card.filled(
            shape: RoundedRectangleBorder(
              borderRadius: CornerRadius.mediumRadius,
            ),
            child: InkWell(
              borderRadius: CornerRadius.mediumRadius,
              onTap: () => onTapSosmed(item),
              child: Padding(
                padding: const EdgeInsets.all(PaddingStyle.medium),
                child: SvgPicture.asset(icon, height: 32, width: 32),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  void onTapSosmed(Sosmed sosmed) async {
    final Sosmed(:String? deeplink, :String? url, :String title) = sosmed;
    final bool canLaunch =
        deeplink != null && await canLaunchUrlString(deeplink);

    if (canLaunch) {
      logger.d('Launched Deeplink');
      await launchUrlString(deeplink);
      return;
    }

    if (url == null || url.isEmpty) return;
    AppRoute.to(WebviewScreen(url: url, title: title));
  }
}
