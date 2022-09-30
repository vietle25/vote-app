import 'package:chopper/chopper.dart';
import 'package:flutter_app/configs/server.dart';
import 'package:flutter_app/models/common/common_filter.dart';
import 'package:flutter_app/models/response/api_response.dart';
import 'package:flutter_app/repositories/api_client.dart';

part 'notification_repository.chopper.dart';

@ChopperApi(baseUrl: 'notification/')
abstract class NotificationRepository extends ApiClient {
  static NotificationRepository? manager;

  static NotificationRepository create() {
    final client = ApiClient.create(url: Server.apiUrl);
    return _$NotificationRepository(client);
  }

  static NotificationRepository getInstance() {
    if (manager == null) {
      manager = NotificationRepository.create();
      return manager!;
    }
    return manager!;
  }

  @Post(path: '')
  Future<Response<ApiResponse>> getNotifications(@Body() CommonFilter body);

  @Post(path: 'seen')
  Future<Response<ApiResponse>> seenNotification(@Body() CommonFilter body);

  @Get(path: 'count')
  Future<Response<ApiResponse>> countUnSeenNotification();
}
