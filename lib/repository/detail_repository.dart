import 'package:injectable/injectable.dart';

import '../data/base_result.dart';
import '../data/network/api_services.dart';
import '../model/detail_drama.dart';
import '../utils/export_utils.dart';

abstract class DetailRepository {
  Future<BaseResult<DetailDrama>> getDetailShow(String id);
}

@Injectable(as: DetailRepository)
class DetailRepositoryImpl implements DetailRepository {
  final ApiServices _apiServices;

  DetailRepositoryImpl(this._apiServices);

  @override
  Future<BaseResult<DetailDrama>> getDetailShow(String id) =>
      _apiServices.show(id).awaitResponse;
}
