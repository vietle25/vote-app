import 'package:chopper/chopper.dart';
import 'package:flutter_app/configs/server.dart';
import 'package:flutter_app/models/conversation/conversation_filter.dart';
import 'package:flutter_app/models/response/api_response.dart';
import 'package:flutter_app/repositories/api_client.dart';

part 'conversation_repository.chopper.dart';

@ChopperApi(baseUrl: 'conversation/')
abstract class ConversationRepository extends ApiClient {
  static ConversationRepository? manager;

  static ConversationRepository create() {
    final client = ApiClient.create(url: Server.apiUrl);
    return _$ConversationRepository(client);
  }

  static ConversationRepository getInstance() {
    if (manager == null) {
      manager = ConversationRepository.create();
      return manager!;
    }
    return manager!;
  }

  @Get(path: '')
  Future<Response<ApiResponse>> getConversation();

  @Post(path: 'create')
  Future<Response<ApiResponse>> createConversation(
      @Body() ConversationFilter filter);
}
