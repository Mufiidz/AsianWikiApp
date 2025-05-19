import 'package:flutter/material.dart';

import '../utils/export_utils.dart';

class ErrorScreen extends StatelessWidget {
  final String errorMessage;
  const ErrorScreen({required this.errorMessage, super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Container(
        width: context.mediaSize.width,
        height: context.heightWithToolbar,
        alignment: Alignment.center,
        child: Text(
          errorMessage,
          style: context.textTheme.bodyMedium?.copyWith(
            color: context.colorScheme.error,
          ),
        ),
      ),
    );
  }
}
