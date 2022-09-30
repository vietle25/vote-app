import 'package:chopper/chopper.dart';
import 'package:flutter_app/configs/server.dart';
import 'package:flutter_app/models/common/common_filter.dart';
import 'package:flutter_app/models/response/api_response.dart';
import 'package:flutter_app/repositories/api_client.dart';

part 'common_repository.chopper.dart';

@ChopperApi(baseUrl: 'common/')
abstract class CommonRepository extends ApiClient {
  static CommonRepository? manager;

  static CommonRepository create() {
    final client = ApiClient.create(url: Server.apiUrl);
    return _$CommonRepository(client);
  }

  static CommonRepository getInstance() {
    if (manager == null) {
      manager = CommonRepository.create();
      return manager!;
    }
    return manager!;
  }

  @Post(path: 'countries')
  Future<Response<ApiResponse>> getCountries(@Body() CommonFilter body);

  @Get(path: 'countries/{code}')
  Future<Response<ApiResponse>> getCountryByCode(@Path('code') String code);

  @Get(path: 'config')
  Future<Response<ApiResponse>> getConfig();
}
