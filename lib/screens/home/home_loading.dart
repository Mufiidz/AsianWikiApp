import 'package:flutter/material.dart';

import '../../styles/export_styles.dart';
import '../../utils/export_utils.dart';
import '../../widgets/export_widget.dart';

class HomeLoading extends StatelessWidget {
  final bool isLoading;
  const HomeLoading({super.key, this.isLoading = true});

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      isLoading: isLoading,
      child: Padding(
        padding: PaddingStyle.mediumHorizontal,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: context.mediaSize.width,
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: CornerRadius.smallRadius,
                  color: Colors.grey.shade200,
                ),
              ),
              Spacing.mediumSpacing,
              Container(
                width: context.mediaSize.width / 2,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: CornerRadius.smallRadius,
                  color: Colors.grey.shade200,
                ),
              ),
              Spacing.mediumSpacing,
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 6,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: context.mediaSize.width > 600 ? 4 : 2,
                  crossAxisSpacing: Spacing.small,
                  mainAxisSpacing: Spacing.small,
                  mainAxisExtent: context.mediaSize.width > 600 ? 300 : 250,
                ),
                itemBuilder:
                    (BuildContext context, int index) => Container(
                      width: context.mediaSize.width,
                      decoration: BoxDecoration(
                        borderRadius: CornerRadius.smallRadius,
                        color: Colors.grey.shade200,
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
