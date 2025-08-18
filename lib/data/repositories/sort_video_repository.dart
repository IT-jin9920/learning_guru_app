import 'package:dio/dio.dart';

import 'package:learning_guru_app/core/models/api_response_model.dart';
import 'package:learning_guru_app/core/constants/api_endpoints.dart';
import 'package:learning_guru_app/core/network/dio_client.dart';

class SortVideoRepository {
  final _network = NetworkService.instance;

  /// Fetches all sort videos.
  Future<ApiResponseModel> getAllSortVideos() async {
    return await _network.get(ApiEndpoints.sortVideoBase);  // or a specific endpoint if available
  }

  /// Fetches a sort video by ID.
  Future<ApiResponseModel> getSortVideoById(int id) async {
    return await _network.get(ApiEndpoints.sortVideoById(id));
  }

  /// Creates a new sort video.
  Future<ApiResponseModel> createSortVideo({
    required int userId,
    required String name,
    required int categoryId,
    required MultipartFile video,
  }) async {
    final formData = FormData.fromMap({
      "user_id": userId,
      "name": name,
      "category_id": categoryId,
      "video": video,
    });

    return await _network.postMultipart(ApiEndpoints.createSortVideo(), formData: formData);
  }

  /// Updates an existing sort video.
  Future<ApiResponseModel> updateSortVideo(
      int id, {
        required String name,
        required int categoryId,
        MultipartFile? video,
      }) async {
    final formData = FormData.fromMap({
      "name": name,
      "category_id": categoryId,
      if (video != null) "video": video,
    });

    return await _network.put(ApiEndpoints.updateSortVideo(id), data: formData);
  }

  /// Deletes a sort video by ID.
  Future<ApiResponseModel> deleteSortVideo(int id) async {
    return await _network.delete(ApiEndpoints.deleteSortVideo(id));
  }
}
