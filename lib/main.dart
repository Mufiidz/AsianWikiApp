import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization_loader/easy_localization_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timezone/data/latest.dart' as tz;

import 'config/notification/notification_service.dart';
import 'di/injection.dart';
import 'model/asianwiki_type.dart';
import 'model/upcoming.dart';
import 'res/constants/constants.dart' as constants;
import 'screens/deeplink/deeplink_screen.dart';
import 'screens/home/home_screen.dart';
import 'screens/settings/cubit/settings_cubit.dart';
import 'utils/export_utils.dart';

void main() async {
  await initialize();
  runApp(
    EasyLocalization(
      supportedLocales: const <Locale>[Locale('id'), Locale('en')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      startLocale: const Locale('id'),
      assetLoader: const JsonAssetLoader(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final StreamSubscription<Uri> _deeplinkSubscription;

  @override
  void initState() {
    super.initState();
    _deeplinkSubscription = getIt<AppLinks>().uriLinkStream.listen((Uri uri) {
      final List<String> paths = uri.pathSegments;
      final String id = (uri.scheme == 'http' || uri.scheme == 'https')
          ? paths.last
          : paths.first;

      logger.d(id);
      AppRoute.to(DeeplinkScreen(id: id));
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SettingsCubit>(
      create: (BuildContext context) => getIt<SettingsCubit>()..initial(),
      child: BlocSelector<SettingsCubit, SettingsState, ThemeMode>(
        selector: (SettingsState state) => state.selectedTheme,
        builder: (BuildContext context, ThemeMode theme) => MaterialApp(
          title: constants.appName,
          navigatorKey: AppRoute.navigatorKey,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          theme: context.materialTheme.light(),
          darkTheme: context.materialTheme.dark(),
          themeMode: theme,
          home: const HomeScreen(),
          // builder: (BuildContext context, Widget? child) {
          //   ErrorWidget.builder = (FlutterErrorDetails details) {};
          //   return child!;
          // },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _deeplinkSubscription.cancel();
    super.dispose();
  }
}

Future<void> initialize() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.wait(<Future<void>>[
    EasyLocalization.ensureInitialized(),
    setupDI(),
  ]);
  await getIt<NotificationService>().init();
  UpcomingMapper.ensureInitialized();
  AsianwikiTypeMapper.ensureInitialized();
  tz.initializeTimeZones();
}
