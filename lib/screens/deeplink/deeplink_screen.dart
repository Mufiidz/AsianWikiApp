import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../config/env.dart';
import '../../di/injection.dart';
import '../../model/asianwiki_type.dart';
import '../../model/person.dart';
import '../../model/show.dart';
import '../../utils/export_utils.dart';
import '../detail/person/detail_person_screen.dart';
import '../detail/show/detail_show_screen.dart';
import '../webview/webview_screen.dart';
import 'cubit/deeplink_cubit.dart';

class DeeplinkScreen extends StatefulWidget {
  final String id;
  const DeeplinkScreen({required this.id, super.key});

  @override
  State<DeeplinkScreen> createState() => _DeeplinkScreenState();
}

class _DeeplinkScreenState extends State<DeeplinkScreen> {
  late final DeeplinkCubit _cubit;

  @override
  void initState() {
    _cubit = getIt<DeeplinkCubit>();
    super.initState();
    final String id = widget.id;
    if (id.isNotEmpty) {
      logger.d(id);
      _cubit.getType(id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<DeeplinkCubit, DeeplinkState>(
        bloc: _cubit,
        listener: (BuildContext context, DeeplinkState state) {
          final String id = widget.id;
          if (state.isSuccess) {
            final StatefulWidget dest = switch (state.type) {
              AsianwikiType.actress => DetailPersonScreen(
                person: Person(id: id),
              ),
              AsianwikiType.drama ||
              AsianwikiType.movie => DetailShowScreen(drama: Show(id: id)),
              _ => WebviewScreen(url: '${Env.asianwikiUrl}/$id'),
            };
            AppRoute.clearTopTo(dest);
          }
          if (state.isError) {
            AppRoute.back();
          }
        },
        child: const SizedBox.shrink(),
      ),
    );
  }
}
