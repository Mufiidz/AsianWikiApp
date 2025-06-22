import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config/env.dart';
import '../data/network/api_services.dart';
import '../res/constants/sharedpref_keys.dart' as sharedpref_keys;
import '../utils/export_utils.dart';

@module
@injectable
abstract class AppModule {
  @preResolve
  Future<Dio> dio() async {
    logger.d('Dio Called');

    final BaseOptions options = BaseOptions(
      connectTimeout: const Duration(seconds: 15),
      sendTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      responseType: ResponseType.json,
      contentType: ContentType.json.value,
    );

    final Dio dio = Dio(options);

    if (kReleaseMode) return dio;

    final PrettyDioLogger dioLogger = PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
    );

    dio.interceptors.addAll(<Interceptor>[dioLogger]);
    return dio;
  }

  @lazySingleton
  ApiServices apiServices(Dio dio) => ApiServices(
    dio,
    baseUrl: Platform.isAndroid ? Env.baseUrlAndroid : Env.baseUrlIos,
  );

  @singleton
  SharedPreferencesAsync get prefs => SharedPreferencesAsync();

  @preResolve
  @singleton
  Future<SharedPreferencesWithCache> get prefCache async =>
      await SharedPreferencesWithCache.create(
        cacheOptions: const SharedPreferencesWithCacheOptions(
          allowList: <String>{
            sharedpref_keys.lastMonthUpcoming,
            sharedpref_keys.lastPageUpcoming,
            sharedpref_keys.theme,
          },
        ),
      );
}
