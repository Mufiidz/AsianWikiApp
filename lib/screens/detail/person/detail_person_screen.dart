import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../di/injection.dart';
import '../../../model/detail_person.dart';
import '../../../model/person.dart';
import '../../../model/person_show.dart';
import '../../../model/show.dart';
import '../../../repository/detail_repository.dart';
import '../../../res/locale_keys.g.dart';
import '../../../styles/export_styles.dart';
import '../../../utils/export_utils.dart';
import '../../../widgets/export_widget.dart';
import '../../webview/webview_screen.dart';
import '../sections/header_detail.dart';
import '../sections/info_detail.dart';
import '../sections/notes_detail.dart';
import '../show/detail_show_screen.dart';
import 'cubit/detail_person_cubit.dart';
import 'sections/biography_section.dart';
import 'sections/person_shows.dart';
import 'sections/sosmed_section.dart';
import 'widgets/item_personshow_widget.dart';

class DetailPersonScreen extends StatefulWidget {
  final Person person;
  const DetailPersonScreen({required this.person, super.key});

  @override
  State<DetailPersonScreen> createState() => _DetailPersonScreenState();
}

class _DetailPersonScreenState extends State<DetailPersonScreen> {
  late final DetailPersonCubit _cubit;
  DetailPerson? _detailPerson;
  late final Person _person;
  List<Widget> _contents = <Widget>[];
  late final SearchController _searchController;

  @override
  void initState() {
    _cubit = getIt<DetailPersonCubit>();
    _person = widget.person;
    _searchController = SearchController();
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _cubit.initial(_person.id, context.locale.languageCode);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: BlocConsumer<DetailPersonCubit, DetailPersonState>(
        bloc: _cubit,
        listener: (BuildContext context, DetailPersonState state) {
          logger.d(state);
          _detailPerson = state.person;
          _contents = _baseContents;
        },
        builder: (BuildContext context, DetailPersonState state) => Stack(
          children: <Widget>[
            RefreshIndicator.adaptive(
              onRefresh: () async {
                _cubit.initial(_person.id, context.locale.languageCode);
                return Future<void>.value();
              },
              child: MediaQuery.removePadding(
                context: context,
                removeTop: !state.isError,
                child: BodyWidget<DetailPersonState>(
                  state: state,
                  child: (BuildContext context, DetailPersonState state) =>
                      ListWidget<Widget>(
                        _contents,
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
                    visible: state.person.shows.isNotEmpty,
                    child: CircleSearchButton(
                      searchController: _searchController,
                      hintText: LocaleKeys.hint_person_show.tr(),
                      suggestionsBuilder:
                          (BuildContext context, SearchController controller) =>
                              getIt<DetailRepository>()
                                  .searchPersonShow(
                                    controller.text,
                                    state.person.shows,
                                  )
                                  .map(
                                    (ItemPersonShow item) =>
                                        ItemPersonShowWidget(personShow: item),
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

  List<Widget> get _baseContents => <Widget>[
    HeaderDetail(
      image: _detailPerson?.imageUrl ?? _person.imageUrl,
      title: _detailPerson?.name ?? _person.name,
      heroId: _person.id,
    ),
    SosmedSection(sosmeds: _detailPerson?.sosmed),
    InfoDetail(infos: _detailPerson?.info),
    BiographySection(biographies: _detailPerson?.biographies),
    NotesDetail(notes: _detailPerson?.notes, onTapUrl: _onTapUrl),
    PersonShows(personShows: _detailPerson?.shows),
  ];

  void _onTapUrl(String url, String? title) {
    logger.d('Opening $url with title $title');
    final bool isUrl = url.isValidUrl();

    if (isUrl) {
      AppRoute.to(WebviewScreen(url: url, title: title));
    } else {
      final String showId = url.replaceFirst('/', '');
      AppRoute.to(DetailShowScreen(drama: Show(id: showId)));
    }
  }

  @override
  void dispose() {
    clearMemoryImageCache();
    super.dispose();
  }
}
