import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization_loader/easy_localization_loader.dart';
import 'package:flutter/material.dart';

import 'di/injection.dart';
import 'model/upcoming.dart';
import 'res/constants/constants.dart' as constants;
import 'screens/home/home_screen.dart';
import 'utils/export_utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.wait(<Future<void>>[
    EasyLocalization.ensureInitialized(),
    setupDI(),
  ]);
  UpcomingMapper.ensureInitialized();
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

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: constants.appName,
      navigatorKey: AppRoute.navigatorKey,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      // theme: context.materialTheme.light(),
      theme: context.materialTheme.dark(),
      // theme:
      //     context.theme.isDark
      //         ? context.materialTheme.dark()
      //         : context.materialTheme.light(),
      home: const HomeScreen(),
      // builder: (BuildContext context, Widget? child) {
      //   ErrorWidget.builder = (FlutterErrorDetails details) {};
      //   return child!;
      // },
    );
  }
}
