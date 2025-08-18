import 'package:dio/dio.dart';

import 'package:learning_guru_app/core/models/api_response_model.dart';
import 'package:learning_guru_app/core/constants/api_endpoints.dart';
import 'package:learning_guru_app/core/network/dio_client.dart';

class ChatRepository {
  final _network = NetworkService.instance;

  Future<ApiResponseModel> sendMessage({
    required int senderId,
    int? receiverId,
    int? groupId,
    required String message,
    required String messageType,
  }) async {
    final formData = FormData.fromMap({
      "sender_id": senderId,
      if (receiverId != null) "receiver_id": receiverId,
      if (groupId != null) "group_id": groupId,
      "message": message,
      "message_type": messageType,
    });

    return await _network.postMultipart(ApiEndpoints.sendMessage(), formData: formData);
  }

  Future<ApiResponseModel> createGroup({
    required String name,
    required String type,
    required int createdBy,
  }) async {
    final data = {"name": name, "type": type, "created_by": createdBy};
    return await _network.post(ApiEndpoints.createGroup(), data: data);
  }

  Future<ApiResponseModel> addUserToGroup({
    required int groupId,
    required int userId,
  }) async {
    final data = {"group_id": groupId, "user_id": userId};
    return await _network.post(ApiEndpoints.addUserToGroup(), data: data);
  }

  Future<ApiResponseModel> editMessage(int messageId, {required int userId, required String newMessage}) async {
    final data = {"user_id": userId, "new_message": newMessage};
    return await _network.put(ApiEndpoints.editMessage(messageId), data: data);
  }

  Future<ApiResponseModel> markMessageAsRead(int messageId) async {
    return await _network.put(ApiEndpoints.markRead(messageId));
  }

  Future<ApiResponseModel> deleteMessage(int messageId, {required int userId}) async {
    final data = {"user_id": userId};
    return await _network.delete(ApiEndpoints.deleteMessage(messageId), headers: {"Content-Type": "application/json"});
  }

  Future<ApiResponseModel> getMessages({int? groupId, int? user1, int? user2}) async {
    final params = {
      if (groupId != null) "group_id": groupId,
      if (user1 != null) "user1": user1,
      if (user2 != null) "user2": user2,
    };
    return await _network.get(ApiEndpoints.getMessages(), queryParameters: params);
  }

  Future<ApiResponseModel> getUserGroups(int userId) async {
    return await _network.get(ApiEndpoints.getUserGroups(userId));
  }

  Future<ApiResponseModel> getMessagesBetweenUsers(int user1, int user2) async {
    return await _network.get(ApiEndpoints.getMessagesBetweenUsers(user1, user2));
  }
}
