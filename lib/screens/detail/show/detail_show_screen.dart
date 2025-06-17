import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/env.dart';
import '../../../data/network/cast_response.dart';
import '../../../di/injection.dart';
import '../../../model/cast_show.dart';
import '../../../model/detail_show.dart';
import '../../../model/person.dart';
import '../../../model/show.dart';
import '../../../repository/detail_repository.dart';
import '../../../res/locale_keys.g.dart';
import '../../../styles/export_styles.dart';
import '../../../utils/export_utils.dart';
import '../../../widgets/export_widget.dart';
import '../../webview/webview_screen.dart';
import '../person/detail_person_screen.dart';
import '../sections/header_detail.dart';
import '../sections/info_detail.dart';
import '../sections/main_info_detail.dart';
import '../sections/notes_detail.dart';
import 'cubit/detail_drama_cubit.dart';
import 'sections/casts_detail.dart';
import 'sections/synopsis_detail.dart';

class DetailShowScreen extends StatefulWidget {
  final Show drama;
  const DetailShowScreen({required this.drama, super.key});

  @override
  State<DetailShowScreen> createState() => _DetailShowScreenState();
}

class _DetailShowScreenState extends State<DetailShowScreen>
    with SingleTickerProviderStateMixin {
  late final Show _drama;
  late final DetailDramaCubit _detailDramaCubit;
  late final ScrollController _scrollController;
  DetailShow? _detailDrama;
  String _showId = '';
  List<Widget> _contents = <Widget>[];
  late final SearchController _searchController;

  @override
  void initState() {
    _drama = widget.drama;
    _detailDramaCubit = getIt<DetailDramaCubit>();
    _scrollController = ScrollController();
    _searchController = SearchController();
    super.initState();
    _showId = _drama.id;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _detailDramaCubit.getAllDetail(_showId, context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: BlocConsumer<DetailDramaCubit, DetailDramaState>(
        bloc: _detailDramaCubit,
        listener: (BuildContext context, DetailDramaState state) {
          _detailDrama = state.drama;
          _contents = _baseContents;
          final String errorMessage = state.message.toLowerCase();

          RegExp regExp = RegExp(r'\(([^)]+)\)');
          Match? match = regExp.firstMatch(errorMessage);
          String? result = match?.group(1);

          if (state.isError) {
            if (result != null && result.isNotEmpty && result == 'actrees') {
              AppRoute.clearTopTo(
                DetailPersonScreen(person: Person(id: _showId)),
              );
            } else {
              AppRoute.clearTopTo(
                WebviewScreen(url: '${Env.asianwikiUrl}/$_showId'),
              );
            }
          }

          final String? notes = state.drama?.notes;

          if (notes == null || notes.isEmpty) {
            _contents.removeAt(4);
          }
        },
        builder: (BuildContext context, DetailDramaState state) => Stack(
          children: <Widget>[
            RefreshIndicator.adaptive(
              onRefresh: () async {
                _detailDramaCubit.getAllDetail(_showId, context);
                return Future<void>.value();
              },
              child: MediaQuery.removePadding(
                context: context,
                removeTop: !state.isError,
                child: BodyWidget<DetailDramaState>(
                  state: state,
                  child: (BuildContext context, DetailDramaState state) =>
                      ListWidget<Widget>(
                        _contents,
                        controller: _scrollController,
                        itemBuilder:
                            (BuildContext context, Widget item, int index) {
                              if (index == 0) return item;
                              return Padding(
                                padding: PaddingStyle.mediumHorizontal,
                                child: item,
                              );
                            },
                      ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: kToolbarHeight,
                left: PaddingStyle.medium,
                right: PaddingStyle.medium,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  CircleButtonWidget.icon(
                    Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
                    onPressed: () => AppRoute.back(),
                  ),
                  Visibility(
                    visible: state.casts.isNotEmpty,
                    child: CircleSearchButton(
                      searchController: _searchController,
                      hintText: LocaleKeys.hint_cast.tr(),
                      suggestionsBuilder:
                          (
                            BuildContext context,
                            SearchController controller,
                          ) => getIt<DetailRepository>()
                              .searchCast(controller.text, state.casts)
                              .map(
                                (CastShow cast) => ListTile(
                                  title: Text(cast.name),
                                  subtitle: Text(
                                    '${LocaleKeys.as.tr()} ${cast.cast ?? '-'}',
                                  ),
                                  leading: cast.imageUrl != null
                                      ? ImageNetwork(
                                          cast.imageUrl!,
                                          context,
                                          shape: BoxShape.circle,
                                          width: 40,
                                          height: 40,
                                        )
                                      : null,
                                  onTap: () => AppRoute.to(
                                    DetailPersonScreen(person: cast.toPerson),
                                  ),
                                ),
                              )
                              .toList(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ISSUE : non smoth scroll
  List<Widget> get _baseContents => <Widget>[
    HeaderDetail(
      heroId: widget.drama.id,
      image: _detailDrama?.imageUrl ?? '',
      title: _detailDrama?.title ?? widget.drama.title,
    ),
    MainInfoDetail(mainInfos: _detailDrama?.mainInfo),
    InfoDetail(infos: _detailDrama?.getInfo()),
    SynopsisDetail(synopsis: _detailDrama?.getSynopsis()),
    NotesDetail(notes: _detailDrama?.notes, onTapUrl: _onTapUrl),
    BlocSelector<DetailDramaCubit, DetailDramaState, List<CastResponse>>(
      bloc: _detailDramaCubit,
      selector: (DetailDramaState state) => state.casts,
      builder: (BuildContext context, List<CastResponse> state) =>
          CastsDetail(casts: state),
    ),
  ];

  void _onTapUrl(String url, String? title) {
    final bool isUrl = url.isValidUrl();

    if (isUrl) {
      AppRoute.to(WebviewScreen(url: url, title: title));
    } else {
      _showId = url.replaceFirst('/', '');
      AppRoute.to(DetailShowScreen(drama: Show(id: _showId)));
    }
  }

  @override
  void dispose() {
    clearMemoryImageCache();
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}
