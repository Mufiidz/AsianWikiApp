import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../model/detail_person.dart';
import '../../model/detail_show.dart';
import '../../model/search.dart';
import '../../model/search_type.dart';
import '../../model/show.dart';
import '../../model/upcoming.dart';
import '../../res/constants/endpoints.dart' as endpoint;
import 'base_response.dart';
import 'cast_response.dart';

part 'api_services.g.dart';

@RestApi()
abstract class ApiServices {
  @factoryMethod
  factory ApiServices(@factoryParam Dio dio, {@factoryParam String baseUrl}) =
      _ApiServices;

  @GET(endpoint.slider)
  Future<BaseResponse<List<Show>>> slider();

  @GET(endpoint.allUpcoming)
  Future<BaseResponse<List<Upcoming>>> allUpcoming(
    @Query('month') int month, {
    @Query('page') int? page = 1,
  });

  @GET(endpoint.search)
  Future<BaseResponse<List<Search>>> search(
    @Query('query') String query,
    @Query('type') SearchType searchType,
  );

  @GET(endpoint.show)
  Future<BaseResponse<DetailShow>> show(
    @Path('id') String id,
    @Query('lang') String? langCode,
  );

  @GET(endpoint.cast)
  Future<BaseResponse<List<CastResponse>>> casts(@Path('id') String id);

  @GET(endpoint.person)
  Future<BaseResponse<DetailPerson>> person(
    @Path('id') String id,
    @Query('lang') String? langCode,
  );
}
