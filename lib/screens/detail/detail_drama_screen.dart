import 'dart:io';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../di/injection.dart';
import '../../model/detail_drama.dart';
import '../../model/drama.dart';
import '../../styles/export_styles.dart';
import '../../utils/export_utils.dart';
import '../../widgets/export_widget.dart';
import '../webview/webview_screen.dart';
import 'cubit/detail_drama_cubit.dart';
import 'sections/header_detail.dart';
import 'sections/info_detail.dart';
import 'sections/main_info_detail.dart';
import 'sections/notes_detail.dart';
import 'sections/synopsis_detail.dart';

class DetailDramaScreen extends StatefulWidget {
  final Drama drama;
  const DetailDramaScreen({required this.drama, super.key});

  @override
  State<DetailDramaScreen> createState() => _DetailDramaScreenState();
}

class _DetailDramaScreenState extends State<DetailDramaScreen>
    with SingleTickerProviderStateMixin {
  late final Drama _drama;
  late final DetailDramaCubit _detailDramaCubit;
  late final ScrollController _scrollController;
  DetailDrama? _detailDrama;
  String _showId = '';
  late final Animation<double> _animation;
  late final AnimationController _animationController;

  @override
  void initState() {
    _drama = widget.drama;
    _detailDramaCubit = getIt<DetailDramaCubit>();
    _scrollController = ScrollController();
    super.initState();
    _showId = _drama.id;
    _detailDramaCubit.getDetail(_showId);
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_animationController);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: Stack(
        children: <Widget>[
          BlocConsumer<DetailDramaCubit, DetailDramaState>(
            bloc: _detailDramaCubit,
            listener: (BuildContext context, DetailDramaState state) {
              _detailDrama = state.drama;
            },
            builder: (BuildContext context, DetailDramaState state) {
              return RefreshIndicator.adaptive(
                onRefresh: () async {
                  _detailDramaCubit.getDetail(_showId);
                  return Future<void>.value();
                },
                child: MediaQuery.removePadding(
                  context: context,
                  removeTop: !state.isError,
                  child: BodyWidget<DetailDramaState>(
                    state: state,
                    child:
                        (BuildContext context, DetailDramaState state) =>
                            ListWidget<Widget>(
                              _contents,
                              controller: _scrollController,
                              isSeparated: true,
                              itemBuilder: (
                                BuildContext context,
                                Widget item,
                                int index,
                              ) {
                                if (index == 0) return item;
                                return Padding(
                                  padding: PaddingStyle.mediumHorizontal,
                                  child: item,
                                );
                              },
                              separatorBuilder:
                                  (
                                    BuildContext context,
                                    Widget item,
                                    int index,
                                  ) => SizedBox(
                                    height: index == 0 || index == 1 ? 8 : 24,
                                  ),
                            ),
                  ),
                ),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: kToolbarHeight,
              left: 16,
            ),
            child: Row(
              children: <Widget>[
                ElevatedButton(
                  onPressed: () => AppRoute.back(),
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    iconSize: 24,
                    padding: const EdgeInsets.all(8),
                    fixedSize: const Size.square(48),
                  ),
                  child: Icon(
                    Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> get _contents => <Widget>[
    HeaderDetail(
      heroId: widget.drama.id,
      image: _detailDrama?.imageUrl ?? '',
      title: _detailDrama?.title ?? widget.drama.title,
      animation: _animation,
    ),
    MainInfoDetail(detailDrama: _detailDrama),
    InfoDetail(infos: _detailDrama?.getInfo()),
    SynopsisDetail(synopsis: _detailDrama?.synopsis),
    NotesDetail(
      notes: _detailDrama?.notes,
      onTapUrl: (String url) {
        final bool isUrl = url.isValidUrl();
        if (isUrl) {
          AppRoute.to(WebviewScreen(url: url));
        } else {
          _showId = url.replaceFirst('/', '');
          AppRoute.to(DetailDramaScreen(drama: Drama(id: _showId)));
        }
      },
    ),
  ];

  @override
  void dispose() {
    clearMemoryImageCache();
    _animationController.dispose();
    super.dispose();
  }
}
