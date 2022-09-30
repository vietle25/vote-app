import 'package:chopper/chopper.dart';
import 'package:flutter_app/configs/server.dart';
import 'package:flutter_app/models/feedback/feedback_filter.dart';
import 'package:flutter_app/models/response/api_response.dart';
import 'package:flutter_app/repositories/api_client.dart';

part 'feedback_repository.chopper.dart';

@ChopperApi(baseUrl: 'feedback/')
abstract class FeedbackRepository extends ApiClient {
  static FeedbackRepository? manager;

  static FeedbackRepository create() {
    final client = ApiClient.create(url: Server.apiUrl);
    return _$FeedbackRepository(client);
  }

  static FeedbackRepository getInstance() {
    if (manager == null) {
      manager = FeedbackRepository.create();
      return manager!;
    }
    return manager!;
  }

  @Post(path: 'update')
  Future<Response<ApiResponse>> updateFeedback(@Body() FeedbackFilter body);
}