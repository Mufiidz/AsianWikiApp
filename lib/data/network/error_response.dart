import 'package:dart_mappable/dart_mappable.dart';

part 'error_response.mapper.dart';

@MappableClass()
class ErrorResponse with ErrorResponseMappable {
  int code;
  String status;
  String message;

  ErrorResponse({
    this.code = 0,
    this.status = '',
    this.message = '',
  });


}
