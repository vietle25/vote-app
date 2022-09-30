import 'package:chopper/chopper.dart';
import 'package:flutter_app/configs/server.dart';
import 'package:flutter_app/models/common/device_model.dart';
import 'package:flutter_app/models/response/api_response.dart';
import 'package:flutter_app/models/singer/singer_filter.dart';
import 'package:flutter_app/models/user/change_pass_filter.dart';
import 'package:flutter_app/models/user/user_device_model.dart';
import 'package:flutter_app/models/user/user_model.dart';
import 'package:flutter_app/models/user/user_verify_model.dart';

import 'api_client.dart';

part 'user_repository.chopper.dart';

@ChopperApi(baseUrl: 'user/')
abstract class UserRepository extends ApiClient {
  static UserRepository? manager;

  static UserRepository create() {
    final client = ApiClient.create(url: Server.apiUrl);
    return _$UserRepository(client);
  }

  static UserRepository getInstance() {
    if (manager == null) {
      manager = UserRepository.create();
      return manager!;
    }
    return manager!;
  }

  @Post(path: 'device')
  Future<Response<ApiResponse>> saveUserDevice(@Body() DeviceModel body);

  @Post(path: 'singer/list')
  Future<Response<ApiResponse>> getAllSingers(@Body() SingerFilter body);

  @Post(path: 'singer/profile')
  Future<Response<ApiResponse>> getSingerDetail(@Body() SingerFilter body);

  @Get(path: 'profile')
  Future<Response<ApiResponse>> getProfile();

  @Post(path: 'login-social')
  Future<Response<ApiResponse>> loginSocial(@Body() UserModel body);

  @Post(path: 'device/delete')
  Future<Response<ApiResponse>> deleteUserDevice(@Body() UserDeviceModel body);

  @Post(path: 'update')
  Future<Response<ApiResponse>> updateProfile(@Body() UserModel body);

  @Get(path: 'verify')
  Future<Response<ApiResponse>> getVerify();

  @Post(path: 'verify/update')
  Future<Response<ApiResponse>> updateVerify(@Body() UserVerifyModel body);

  @Post(path: 'exist')
  Future<Response<ApiResponse>> checkUserExist(@Body() UserModel body);

  @Post(path: 'reset-password')
  Future<Response<ApiResponse>> resetPassword(@Body() UserModel body);

  @Post(path: 'password/change')
  Future<Response<ApiResponse>> changePass(@Body() ChangePassFilter body);

  @Post(path: 'pin/update')
  Future<Response<ApiResponse>> updatePin(@Body() UserModel body);

  @Post(path: 'request-delete')
  Future<Response<ApiResponse>> requestDelete(@Body() UserModel model);

  @Post(path: 'cancel-request-delete')
  Future<Response<ApiResponse>> cancelRequestDelete(@Body() UserModel model);
}
