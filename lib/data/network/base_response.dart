import 'package:dart_mappable/dart_mappable.dart';

part 'base_response.mapper.dart';

@MappableClass()
class BaseResponse<T> with BaseResponseMappable<T> {
  final int code;
  final String message;
  final T? data;

  BaseResponse({this.code = 0, this.message = '', this.data});

  factory BaseResponse.fromJson(dynamic json) {
    if (json is Map<String, dynamic>) return BaseResponseMapper.fromJson(json);
    if (json is String) return BaseResponseMapper.fromJsonString(json);
    return throw Exception(
      "The argument type '${json.runtimeType}' can't be assigned",
    );
  }
}
