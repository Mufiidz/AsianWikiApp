import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
        requestHeader: true, requestBody: true, responseBody: true);

    dio.interceptors.addAll(<Interceptor>[dioLogger]);
    return dio;
  }

  @singleton
  @preResolve
  Future<SharedPreferences> get prefs async =>
      await SharedPreferences.getInstance();
}