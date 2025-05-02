import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../model/drama.dart';
import '../../model/search_type.dart';
import '../../model/upcoming.dart';
import '../../res/constants/endpoints.dart' as endpoint;
import 'base_response.dart';

part 'api_services.g.dart';

@RestApi()
abstract class ApiServices {
  @factoryMethod
  factory ApiServices(@factoryParam Dio dio, {@factoryParam String baseUrl}) =
      _ApiServices;

  @GET(endpoint.slider)
  Future<BaseResponse<List<Drama>>> slider();

  @GET(endpoint.upcoming)
  Future<BaseResponse<List<Upcoming>>> upcoming(
    @Query('month') int month, {
    @Query('page') int? page = 1,
  });

  @GET(endpoint.search)
  Future<BaseResponse<List<Drama>>> search(
    @Query('search') String query,
    @Query('type') SearchType searchType,
  );
}
