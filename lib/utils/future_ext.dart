import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';

import '../data/base_result.dart';
import '../res/locale_keys.g.dart';
import 'export_utils.dart';

extension FutureExt<T> on Future<T> {
  Future<BaseResult<T>> get awaitResponse async {
    try {
      return DataResult<T>(await this);
    } on DioException catch (dioException) {
      final Response<dynamic>? response = dioException.response;
      final DioExceptionType errorType = dioException.type;

      if (errorType == DioExceptionType.connectionTimeout) {
        return ErrorResult<T>(LocaleKeys.connection_timeout.tr());
      }

      if (errorType == DioExceptionType.connectionError) {
        return ErrorResult<T>(LocaleKeys.connection_error.tr());
      }

      logger
        ..e('response: $response')
        ..e('response: ${dioException.message}');

      if (response == null) {
        return ErrorResult<T>(
            dioException.message ?? LocaleKeys.empty_response.tr());
      }
      
      // Convert here for error response
      return ErrorResult<T>(response.data); 
    } catch (e) {
      return ErrorResult<T>(e.toString());
    }
  }
}