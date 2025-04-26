import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';

import '../data/base_result.dart';
import '../data/network/base_response.dart';
import '../data/network/error_response.dart';
import '../res/locale_keys.g.dart';
import 'export_utils.dart';

extension FutureExt<T> on Future<BaseResponse<T>> {
  
  Future<BaseResult<T>> get awaitResponse async {
    try {
      final BaseResponse<T> response = await this;
      logger.d('Success Response: $response');

      final T? data = response.data;

      if (data == null) {
        throw Exception(LocaleKeys.empty_data.tr());
      }
      return DataResult<T>(data);
    } on DioException catch (dioException) {
      final Response<dynamic>? response = dioException.response;
      final DioExceptionType errorType = dioException.type;

      logger
        ..e('response: $response')
        ..e('response message: ${dioException.message}');

      if (errorType == DioExceptionType.connectionTimeout) {
        return ErrorResult<T>(LocaleKeys.connection_timeout.tr());
      }

      if (errorType == DioExceptionType.connectionError) {
        return ErrorResult<T>(LocaleKeys.connection_error.tr());
      }

      if (response == null) {
        return ErrorResult<T>(
          dioException.message ?? LocaleKeys.empty_response.tr(),
        );
      }

      final ErrorResponse errorResponse = ErrorResponseMapper.fromJson(
        response.data,
      );

      if (response.statusCode == 404) {
        return ErrorResult<T>(LocaleKeys.url_not_found.tr());
      }

      // Convert here for error response
      return ErrorResult<T>(
        '${errorResponse.message}. (${errorResponse.code})',
      );
    } catch (e) {
      return ErrorResult<T>('Error: $e');
    }
  }
}