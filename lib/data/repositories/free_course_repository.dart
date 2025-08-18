import 'package:dio/dio.dart';

import 'package:learning_guru_app/core/models/api_response_model.dart';
import 'package:learning_guru_app/core/constants/api_endpoints.dart';
import 'package:learning_guru_app/core/network/dio_client.dart';

class FreeCourseRepository {
  final _network = NetworkService.instance;

  Future<ApiResponseModel> getAllFreeCourses() async {
    return await _network.get(ApiEndpoints.getAllFreeCourses());
  }


  Future<ApiResponseModel> getFreeCourseById(int id) async {
    return await _network.get(ApiEndpoints.freeCourseById(id));
  }

  Future<ApiResponseModel> createFreeCourse({
    required int userId,
    required String name,
    required int categoryId,
    required String description,
    required String studentLearn,
    required MultipartFile thumbnail,
  }) async {
    final formData = FormData.fromMap({
      "user_id": userId,
      "name": name,
      "category_id": categoryId,
      "description": description,
      "student_learn": studentLearn,
      "thumbnail": thumbnail,
    });

    return await _network.postMultipart(ApiEndpoints.createFreeCourse(), formData: formData);
  }

  Future<ApiResponseModel> updateFreeCourse(
      int id, {
        required int userId,
        required String name,
        required int categoryId,
        required String description,
        required String studentLearn,
        MultipartFile? thumbnail,
      }) async {
    final formData = FormData.fromMap({
      "user_id": userId,
      "name": name,
      "category_id": categoryId,
      "description": description,
      "student_learn": studentLearn,
      if (thumbnail != null) "thumbnail": thumbnail,
    });

    return await _network.put(ApiEndpoints.updateFreeCourse(id), data: formData);
  }

  Future<ApiResponseModel> uploadFreeCourseContent({
    required int freeCourseId,
    required String chapters,
    required MultipartFile file,
  }) async {
    final formData = FormData.fromMap({
      "free_courseId": freeCourseId,
      "chapters": chapters,
      "files": file,
    });

    return await _network.postMultipart(ApiEndpoints.uploadFreeCourseContent(), formData: formData);
  }

  Future<ApiResponseModel> updateFreeCourseContent({
    required int freeCourseId,
    required String chapters,
    MultipartFile? file,
  }) async {
    final formData = FormData.fromMap({
      "free_courseId": freeCourseId,
      "chapters": chapters,
      if (file != null) "files": file,
    });

    return await _network.put(ApiEndpoints.updateFreeCourseContent(), data: formData);
  }

  Future<ApiResponseModel> deleteFreeCourse(int id) async {
    return await _network.delete(ApiEndpoints.deleteFreeCourse(id));
  }
}
